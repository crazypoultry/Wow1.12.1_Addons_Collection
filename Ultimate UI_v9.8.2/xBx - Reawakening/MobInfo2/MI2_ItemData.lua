--
-- Base prices for Auctioneer
-- Gathered by Norganna
--
-- This file belongs to Auctioneer. It has been written by Norganna, 
-- the author of Auctioneer.
--
-- I have copied it into MobHealth in order to have item vendor prices
-- available even when Auctioneer has not been installed. Note that if
-- Auctioneer has been installed then the data in here will NOT be used
-- or loaded. When Auctioneer is installed the original Auctioneer data
-- is used.
--
-- The function and the data structure have been renamed to avoid any
-- problems interference. All structure components except for "s=xxx"
-- have been removed to keep the file short.
--

function MobInfo_Auctioneer_BuildBaseData()
MobInfo_Auctioneer_BasePrices = {
	[25]={s=7},  -- Worn Shortsword
	[35]={s=9},  -- Bent Staff
	[36]={s=7},  -- Worn Mace
	[37]={s=7},  -- Worn Axe
	[38]={s=1},  -- Recruit's Shirt
	[39]={s=1},  -- Recruit's Pants
	[40]={s=1},  -- Recruit's Boots
	[43]={s=1},  -- Squire's Boots
	[44]={s=1},  -- Squire's Pants
	[45]={s=1},  -- Squire's Shirt
	[47]={s=1},  -- Footpad's Shoes
	[48]={s=1},  -- Footpad's Pants
	[49]={s=1},  -- Footpad's Shirt
	[51]={s=1},  -- Neophyte's Boots
	[52]={s=1},  -- Neophyte's Pants
	[53]={s=1},  -- Neophyte's Shirt
	[55]={s=1},  -- Apprentice's Boots
	[56]={s=1},  -- Apprentice's Robe
	[57]={s=1},  -- Acolyte's Robe
	[59]={s=1},  -- Acolyte's Shoes
	[60]={s=12},  -- Layered Tunic
	[61]={s=12},  -- Dwarven Leather Pants
	[79]={s=10},  -- Dwarven Cloth Britches
	[80]={s=7},  -- Soft Fur-lined Shoes
	[85]={s=12},  -- Dirty Leather Vest
	[117]={s=1},  -- Tough Jerky
	[118]={s=5},  -- Minor Healing Potion
	[120]={s=1},  -- Thug Pants
	[121]={s=1},  -- Thug Boots
	[127]={s=1},  -- Trapper's Shirt
	[128]={s=1},  -- Deprecated Tauren Trapper's Pants
	[129]={s=1},  -- Rugged Trapper's Boots
	[139]={s=1},  -- Brawler's Pants
	[140]={s=1},  -- Brawler's Boots
	[147]={s=1},  -- Rugged Trapper's Pants
	[148]={s=1},  -- Rugged Trapper's Shirt
	[153]={s=1},  -- Primitive Kilt
	[154]={s=1},  -- Primitive Mantle
	[159]={s=1},  -- Refreshing Spring Water
	[182]={s=0},  -- Garrick's Head
	[193]={s=9},  -- Tattered Cloth Vest
	[194]={s=9},  -- Tattered Cloth Pants
	[195]={s=7},  -- Tattered Cloth Boots
	[200]={s=454},  -- Thick Cloth Vest
	[201]={s=455},  -- Thick Cloth Pants
	[202]={s=342},  -- Thick Cloth Shoes
	[203]={s=229},  -- Thick Cloth Gloves
	[209]={s=12},  -- Dirty Leather Pants
	[210]={s=9},  -- Dirty Leather Boots
	[236]={s=559},  -- Cured Leather Armor
	[237]={s=561},  -- Cured Leather Pants
	[238]={s=422},  -- Cured Leather Boots
	[239]={s=282},  -- Cured Leather Gloves
	[285]={s=711},  -- Scalemail Vest
	[286]={s=645},  -- Scalemail Pants
	[287]={s=488},  -- Scalemail Boots
	[414]={s=6},  -- Dalaran Sharp
	[422]={s=25},  -- Dwarven Mild
	[537]={s=87},  -- Dull Frenzy Scale
	[555]={s=8},  -- Rough Vulture Feathers
	[556]={s=106},  -- Buzzard Beak
	[647]={s=70024},  -- Destiny
	[710]={s=72},  -- Bracers of the People's Militia
	[711]={s=5},  -- Tattered Cloth Gloves
	[714]={s=6},  -- Dirty Leather Gloves
	[718]={s=322},  -- Scalemail Gloves
	[719]={s=4},  -- Rabbit Handler Gloves
	[720]={s=1070},  -- Brawler Gloves
	[723]={s=15},  -- Goretusk Liver
	[724]={s=25},  -- Goretusk Liver Pie
	[725]={s=0},  -- Gnoll Paw
	[727]={s=244},  -- Notched Shortsword
	[728]={s=50},  -- Recipe: Westfall Stew
	[729]={s=17},  -- Stringy Vulture Meat
	[730]={s=16},  -- Murloc Eye
	[731]={s=27},  -- Goretusk Snout
	[732]={s=6},  -- Okra
	[733]={s=100},  -- Westfall Stew
	[735]={s=0},  -- Rolf and Malakai's Medallions
	[737]={s=0},  -- Holy Spring Water
	[738]={s=0},  -- Sack of Barley
	[739]={s=0},  -- Sack of Corn
	[740]={s=0},  -- Sack of Rye
	[742]={s=0},  -- A Sycamore Branch
	[743]={s=0},  -- Bundle of Charred Oak
	[744]={s=10000},  -- Thunderbrew's Boot Flask
	[745]={s=0},  -- Marshal McBride's Documents
	[748]={s=0},  -- Stormwind Armor Marker
	[750]={s=0},  -- Tough Wolf Meat
	[752]={s=0},  -- Red Burlap Bandana
	[753]={s=3842},  -- Dragonmaw Shortsword
	[754]={s=23556},  -- Shortsword of Vengeance
	[755]={s=1},  -- Melted Candle
	[756]={s=4963},  -- Tunnel Pick
	[763]={s=58},  -- Ice-covered Bracers
	[765]={s=10},  -- Silverleaf
	[766]={s=57},  -- Flanged Mace
	[767]={s=100},  -- Long Bo Staff
	[768]={s=113},  -- Lumberjack Axe
	[769]={s=3},  -- Chunk of Boar Meat
	[770]={s=316},  -- Pointy Crocolisk Tooth
	[771]={s=38},  -- Chipped Boar Tusk
	[772]={s=0},  -- Large Candle
	[773]={s=0},  -- Gold Dust
	[774]={s=15},  -- Malachite
	[776]={s=5765},  -- Vendetta
	[777]={s=21},  -- Prowler Teeth
	[778]={s=55},  -- Kobold Excavation Pick
	[779]={s=18},  -- Shiny Seashell
	[780]={s=0},  -- Torn Murloc Fin
	[781]={s=110},  -- Stone Gnoll Hammer
	[782]={s=0},  -- Painted Gnoll Armband
	[783]={s=50},  -- Light Hide
	[785]={s=20},  -- Mageroyal
	[787]={s=1},  -- Slitherskin Mackerel
	[789]={s=1969},  -- Stout Battlehammer
	[790]={s=2020},  -- Forester's Axe
	[791]={s=7069},  -- Gnarled Ash Staff
	[792]={s=41},  -- Knitted Sandals
	[793]={s=27},  -- Knitted Gloves
	[794]={s=55},  -- Knitted Pants
	[795]={s=56},  -- Knitted Tunic
	[796]={s=52},  -- Rough Leather Boots
	[797]={s=35},  -- Rough Leather Gloves
	[798]={s=70},  -- Rough Leather Pants
	[799]={s=71},  -- Rough Leather Vest
	[804]={s=2500},  -- Large Blue Sack
	[805]={s=250},  -- Small Red Pouch
	[809]={s=39125},  -- Bloodrazor
	[810]={s=45267},  -- Hammer of the Northern Wind
	[811]={s=54123},  -- Axe of the Deep Woods
	[812]={s=57018},  -- Glowing Brightwood Staff
	[814]={s=25},  -- Flask of Oil
	[816]={s=305},  -- Small Hand Blade
	[818]={s=100},  -- Tigerseye
	[820]={s=947},  -- Slicer Blade
	[821]={s=249},  -- Riverpaw Leather Vest
	[826]={s=732},  -- Brutish Riverpaw Axe
	[827]={s=971},  -- Wicked Blackjack
	[828]={s=250},  -- Small Blue Pouch
	[829]={s=0},  -- Red Leather Bandana
	[832]={s=203},  -- Silver Defias Belt
	[833]={s=28000},  -- Lifestone
	[835]={s=23},  -- Large Rope Net
	[837]={s=224},  -- Heavy Weave Armor
	[838]={s=225},  -- Heavy Weave Pants
	[839]={s=113},  -- Heavy Weave Gloves
	[840]={s=170},  -- Heavy Weave Shoes
	[841]={s=0},  -- Furlbrow's Pocket Watch
	[843]={s=215},  -- Tanned Leather Boots
	[844]={s=144},  -- Tanned Leather Gloves
	[845]={s=289},  -- Tanned Leather Pants
	[846]={s=290},  -- Tanned Leather Jerkin
	[847]={s=349},  -- Chainmail Armor
	[848]={s=351},  -- Chainmail Pants
	[849]={s=265},  -- Chainmail Boots
	[850]={s=176},  -- Chainmail Gloves
	[851]={s=404},  -- Cutlass
	[852]={s=347},  -- Mace
	[853]={s=481},  -- Hatchet
	[854]={s=604},  -- Quarter Staff
	[856]={s=875},  -- Blue Leather Bag
	[857]={s=2500},  -- Large Red Sack
	[858]={s=25},  -- Lesser Healing Potion
	[859]={s=87},  -- Fine Cloth Shirt
	[860]={s=89},  -- Cavalier's Boots
	[862]={s=38222},  -- Runed Ring
	[863]={s=8964},  -- Gloom Reaper
	[864]={s=9716},  -- Knightly Longsword
	[865]={s=5096},  -- Leaden Mace
	[866]={s=16640},  -- Monk's Staff
	[867]={s=5344},  -- Gloves of Holy Might
	[868]={s=21532},  -- Ardent Custodian
	[869]={s=18529},  -- Dazzling Longsword
	[870]={s=21528},  -- Fiery War Axe
	[871]={s=29627},  -- Flurry Axe
	[872]={s=2011},  -- Rockslicer
	[873]={s=21770},  -- Staff of Jordan
	[878]={s=56},  -- Fist-sized Spinneret
	[880]={s=2692},  -- Staff of Horrors
	[884]={s=0},  -- Ghoul Rib
	[885]={s=2300},  -- Black Metal Axe
	[886]={s=2949},  -- Black Metal Shortsword
	[887]={s=82},  -- Pound of Flesh
	[888]={s=980},  -- Naga Battle Gloves
	[889]={s=0},  -- A Dusty Unsent Letter
	[890]={s=3517},  -- Twisted Chanter's Staff
	[892]={s=369},  -- Gnoll Casting Gloves
	[893]={s=137},  -- Dire Wolf Fang
	[895]={s=0},  -- Worgen Skull
	[896]={s=0},  -- Worgen Fang
	[897]={s=1022},  -- Madwolf Bracers
	[899]={s=1248},  -- Venom Web Fang
	[910]={s=0},  -- An Undelivered Letter
	[911]={s=3324},  -- Ironwood Treebranch
	[914]={s=2669},  -- Large Ogre Chain Armor
	[915]={s=0},  -- Red Silk Bandana
	[916]={s=0},  -- A Torn Journal Page
	[918]={s=1250},  -- Deviate Hide Pack
	[920]={s=2821},  -- Wicked Spiked Mace
	[921]={s=0},  -- A Faded Journal Page
	[922]={s=2407},  -- Dacian Falx
	[923]={s=1748},  -- Longsword
	[924]={s=2194},  -- Maul
	[925]={s=1559},  -- Flail
	[926]={s=1956},  -- Battle Axe
	[927]={s=1390},  -- Double Axe
	[928]={s=1972},  -- Long Staff
	[929]={s=75},  -- Healing Potion
	[932]={s=637},  -- Fel Steed Saddlebags
	[933]={s=2500},  -- Large Rucksack
	[934]={s=10682},  -- Stalvan's Reaper
	[935]={s=1742},  -- Night Watch Shortsword
	[936]={s=11620},  -- Midnight Mace
	[937]={s=14577},  -- Black Duskwood Staff
	[938]={s=0},  -- Muddy Journal Pages
	[939]={s=0},  -- A Bloodstained Journal Page
	[940]={s=12565},  -- Robes of Insight
	[942]={s=4500},  -- Freezing Band
	[943]={s=42863},  -- Warden Staff
	[944]={s=83000},  -- Elemental Mage Staff
	[954]={s=50},  -- Scroll of Strength
	[955]={s=37},  -- Scroll of Intellect
	[957]={s=0},  -- William's Shipment
	[961]={s=2},  -- Healing Herb
	[962]={s=0},  -- Pork Belly Pie
	[981]={s=0},  -- Bernice's Necklace
	[983]={s=21},  -- Red Linen Sash
	[997]={s=3},  -- Fire Sword of Crippling
	[1006]={s=0},  -- Brass Collar
	[1008]={s=144},  -- Well-used Sword
	[1009]={s=490},  -- Compact Hammer
	[1010]={s=99},  -- Gnarled Short Staff
	[1011]={s=80},  -- Sharp Axe
	[1013]={s=0},  -- Iron Rivet
	[1015]={s=24},  -- Lean Wolf Flank
	[1017]={s=100},  -- Seasoned Wolf Kabob
	[1019]={s=0},  -- Red Linen Bandana
	[1024]={s=1},  -- Plate Helmet D2 (test)
	[1027]={s=1},  -- Mail Helmet A (Test)
	[1074]={s=491},  -- Hard Spider Leg Tip
	[1075]={s=0},  -- Shadowhide Pendant
	[1076]={s=650},  -- Defias Renegade Ring
	[1077]={s=25},  -- Defias Mage Ring
	[1080]={s=78},  -- Tough Condor Meat
	[1081]={s=50},  -- Crisp Spider Meat
	[1082]={s=150},  -- Redridge Goulash
	[1083]={s=0},  -- Glyph of Azora
	[1113]={s=0},  -- Conjured Bread
	[1114]={s=0},  -- Conjured Rye
	[1116]={s=1250},  -- Ring of Pure Silver
	[1121]={s=1075},  -- Feet of the Lynx
	[1127]={s=25},  -- Flash Bundle
	[1129]={s=0},  -- Ghoul Fang
	[1130]={s=0},  -- Vial of Spider Venom
	[1131]={s=1136},  -- Totem of Infliction
	[1132]={s=0},  -- Horn of the Timber Wolf
	[1154]={s=102},  -- Belt of the People's Militia
	[1155]={s=5954},  -- Rod of the Sleepwalker
	[1156]={s=812},  -- Lavishly Jeweled Ring
	[1158]={s=146},  -- Solid Metal Club
	[1159]={s=32},  -- Militia Quarterstaff
	[1161]={s=25},  -- Militia Shortsword
	[1168]={s=42296},  -- Skullflame Shield
	[1169]={s=18815},  -- Blackskull Shield
	[1171]={s=55},  -- Well-stitched Robe
	[1172]={s=968},  -- Grayson's Torch
	[1173]={s=52},  -- Weather-worn Boots
	[1175]={s=28},  -- A Gold Tooth
	[1177]={s=3},  -- Oil of Olaf
	[1178]={s=7},  -- Explosive Rocket
	[1179]={s=6},  -- Ice Cold Milk
	[1180]={s=37},  -- Scroll of Stamina
	[1181]={s=25},  -- Scroll of Spirit
	[1182]={s=44},  -- Brass-studded Bracers
	[1183]={s=29},  -- Elastic Wristguards
	[1187]={s=1081},  -- Spiked Collar
	[1189]={s=625},  -- Overseer's Ring
	[1190]={s=630},  -- Overseer's Cloak
	[1191]={s=82},  -- Bag of Marbles
	[1194]={s=20},  -- Bastard Sword
	[1195]={s=47},  -- Kobold Mining Shovel
	[1196]={s=442},  -- Tabar
	[1197]={s=533},  -- Giant Mace
	[1198]={s=535},  -- Claymore
	[1200]={s=16},  -- Large Wooden Shield
	[1201]={s=94},  -- Dull Heater Shield
	[1202]={s=367},  -- Wall Shield
	[1203]={s=23505},  -- Aegis of Stormwind
	[1204]={s=12577},  -- The Green Tower
	[1205]={s=25},  -- Melon Juice
	[1206]={s=400},  -- Moss Agate
	[1207]={s=9892},  -- Murphstar
	[1208]={s=0},  -- Maybell's Love Letter
	[1210]={s=250},  -- Shadowgem
	[1211]={s=347},  -- Gnoll War Harness
	[1212]={s=21},  -- Gnoll Spittle
	[1213]={s=87},  -- Gnoll Kindred Bracers
	[1214]={s=930},  -- Gnoll Punisher
	[1215]={s=469},  -- Support Girdle
	[1217]={s=0},  -- Unknown Reward
	[1218]={s=2064},  -- Heavy Gnoll War Club
	[1219]={s=823},  -- Redridge Machete
	[1220]={s=1807},  -- Lupine Axe
	[1221]={s=0},  -- Underbelly Whelp Scale
	[1251]={s=10},  -- Linen Bandage
	[1252]={s=0},  -- Gramma Stonefield's Note
	[1254]={s=0},  -- Lesser Firestone
	[1256]={s=0},  -- Crystal Kelp Frond
	[1257]={s=0},  -- Invisibility Liquor
	[1260]={s=0},  -- Tharil'zun's Head
	[1261]={s=0},  -- Midnight Orb
	[1262]={s=111},  -- Keg of Thunderbrew Lager
	[1263]={s=79064},  -- Brain Hacker
	[1264]={s=3671},  -- Headbasher
	[1265]={s=11774},  -- Scorpion Sting
	[1270]={s=213},  -- Finely Woven Cloak
	[1273]={s=1656},  -- Forest Chain
	[1274]={s=8},  -- Hops
	[1275]={s=1668},  -- Deputy Chain Coat
	[1276]={s=2220},  -- Fire Hardened Buckler
	[1280]={s=3696},  -- Cloaked Hood
	[1282]={s=2825},  -- Sparkmetal Coif
	[1283]={s=0},  -- Verner's Note
	[1284]={s=0},  -- Crate of Horseshoes
	[1287]={s=703},  -- Giant Tarantula Fang
	[1288]={s=185},  -- Large Venom Sac
	[1292]={s=3300},  -- Butcher's Cleaver
	[1293]={s=0},  -- The State of Lakeshire
	[1294]={s=0},  -- The General's Response
	[1296]={s=1681},  -- Blackrock Mace
	[1297]={s=2038},  -- Robes of the Shadowcaster
	[1299]={s=390},  -- Lesser Belt of the Spire
	[1300]={s=1854},  -- Lesser Staff of the Spire
	[1302]={s=262},  -- Black Whelp Gloves
	[1303]={s=418},  -- Bridgeworker's Gloves
	[1304]={s=279},  -- Riding Gloves
	[1306]={s=352},  -- Wolfmane Wristguards
	[1307]={s=0},  -- Gold Pickup Schedule
	[1309]={s=0},  -- Oslow's Toolbox
	[1310]={s=715},  -- Smith's Trousers
	[1314]={s=362},  -- Ghoul Fingers
	[1315]={s=13000},  -- Lei of Lilies
	[1317]={s=3500},  -- Hardened Root Staff
	[1318]={s=3066},  -- Night Reaver
	[1319]={s=462},  -- Ring of Iron Will
	[1322]={s=68},  -- Fishliver Oil
	[1325]={s=0},  -- Daffodil Bouquet
	[1326]={s=10},  -- Sauteed Sunfish
	[1327]={s=0},  -- Wiley's Note
	[1349]={s=0},  -- Abercrombie's Crate
	[1351]={s=768},  -- Fingerbone Bracers
	[1353]={s=0},  -- Shaw's Report
	[1355]={s=251},  -- Buckskin Cape
	[1357]={s=0},  -- Captain Sander's Treasure Map
	[1358]={s=0},  -- A Clue to Sander's Treasure
	[1359]={s=19},  -- Lion-stamped Gloves
	[1360]={s=42},  -- Stormwind Chain Gloves
	[1361]={s=0},  -- Another Clue to Sander's Treasure
	[1362]={s=0},  -- Final Clue to Sander's Treasure
	[1364]={s=8},  -- Ragged Leather Vest
	[1366]={s=2},  -- Ragged Leather Pants
	[1367]={s=2},  -- Ragged Leather Boots
	[1368]={s=2},  -- Ragged Leather Gloves
	[1369]={s=4},  -- Ragged Leather Belt
	[1370]={s=2},  -- Ragged Leather Bracers
	[1372]={s=2},  -- Ragged Cloak
	[1374]={s=3},  -- Frayed Shoes
	[1376]={s=4},  -- Frayed Cloak
	[1377]={s=1},  -- Frayed Gloves
	[1378]={s=1},  -- Frayed Pants
	[1380]={s=4},  -- Frayed Robe
	[1381]={s=0},  -- A Mysterious Message
	[1382]={s=24},  -- Rock Mace
	[1383]={s=25},  -- Stone Tomahawk
	[1384]={s=11},  -- Dull Blade
	[1386]={s=32},  -- Thistlewood Axe
	[1387]={s=1578},  -- Ghoulfang
	[1388]={s=14},  -- Crooked Staff
	[1389]={s=58},  -- Kobold Mining Mallet
	[1391]={s=1392},  -- Riverpaw Mystic Staff
	[1394]={s=740},  -- Driftwood Club
	[1395]={s=1},  -- Apprentice's Pants
	[1396]={s=1},  -- Acolyte's Pants
	[1399]={s=12},  -- Magic Candle
	[1401]={s=14},  -- Green Tea Leaf
	[1404]={s=10306},  -- Tidal Charm
	[1405]={s=1184},  -- Foamspittle Staff
	[1406]={s=2079},  -- Pearl-encrusted Spear
	[1407]={s=0},  -- Solomon's Plea to Westfall
	[1408]={s=0},  -- Stoutmantle's Response to Solomon
	[1409]={s=0},  -- Solomon's Plea to Darkshire
	[1410]={s=0},  -- Ebonlocke's Response to Solomon
	[1411]={s=68},  -- Withered Staff
	[1412]={s=49},  -- Crude Bastard Sword
	[1413]={s=55},  -- Feeble Sword
	[1414]={s=97},  -- Cracked Sledge
	[1415]={s=72},  -- Carpenter's Mallet
	[1416]={s=72},  -- Rusty Hatchet
	[1417]={s=65},  -- Beaten Battle Axe
	[1418]={s=9},  -- Worn Leather Belt
	[1419]={s=19},  -- Worn Leather Boots
	[1420]={s=18},  -- Worn Leather Bracers
	[1421]={s=28},  -- Worn Hide Cloak
	[1422]={s=6},  -- Worn Leather Gloves
	[1423]={s=18},  -- Worn Leather Pants
	[1425]={s=37},  -- Worn Leather Vest
	[1427]={s=29},  -- Patchwork Shoes
	[1429]={s=7},  -- Patchwork Cloak
	[1430]={s=7},  -- Patchwork Gloves
	[1431]={s=20},  -- Patchwork Pants
	[1433]={s=14},  -- Patchwork Armor
	[1434]={s=43},  -- Glowing Wax Stick
	[1436]={s=458},  -- Frontier Britches
	[1438]={s=70},  -- Warrior's Shield
	[1440]={s=1230},  -- Gnoll Skull Basher
	[1443]={s=21125},  -- Jeweled Amulet of Cainwyn
	[1445]={s=583},  -- Blackrock Pauldrons
	[1446]={s=568},  -- Blackrock Boots
	[1447]={s=22775},  -- Ring of Saviors
	[1448]={s=405},  -- Blackrock Gauntlets
	[1449]={s=1875},  -- Minor Channeling Ring
	[1451]={s=0},  -- Bottle of Zombie Juice
	[1453]={s=0},  -- Spectral Comb
	[1454]={s=3937},  -- Axe of the Enforcer
	[1455]={s=2931},  -- Blackrock Champion's Axe
	[1457]={s=1850},  -- Shadowhide Mace
	[1458]={s=2623},  -- Shadowhide Maul
	[1459]={s=2380},  -- Shadowhide Scalper
	[1460]={s=1768},  -- Shadowhide Two-handed Sword
	[1461]={s=3387},  -- Slayer's Battle Axe
	[1462]={s=1306},  -- Ring of the Shadow
	[1464]={s=71},  -- Buzzard Talon
	[1465]={s=9824},  -- Tigerbane
	[1467]={s=0},  -- Spotted Sunfish
	[1468]={s=28},  -- Murloc Fin
	[1469]={s=1180},  -- Scimitar of Atun
	[1470]={s=875},  -- Murloc Skin Bag
	[1473]={s=1497},  -- Riverside Staff
	[1475]={s=82},  -- Small Venom Sac
	[1476]={s=6},  -- Snapped Spider Limb
	[1477]={s=87},  -- Scroll of Agility II
	[1478]={s=62},  -- Scroll of Protection II
	[1479]={s=47},  -- Salma's Oven Mitts
	[1480]={s=954},  -- Fist of the People's Militia
	[1481]={s=3337},  -- Grimclaw
	[1482]={s=2964},  -- Shadowfang
	[1483]={s=2025},  -- Face Smasher
	[1484]={s=2922},  -- Witching Stave
	[1485]={s=1410},  -- Pitchfork
	[1486]={s=1202},  -- Tree Bark Jacket
	[1487]={s=0},  -- Conjured Pumpernickel
	[1488]={s=3379},  -- Avenger's Armor
	[1489]={s=1553},  -- Gloomshroud Armor
	[1490]={s=8910},  -- Guardian Talisman
	[1491]={s=2207},  -- Ring of Precision
	[1493]={s=3922},  -- Heavy Marauder Scimitar
	[1495]={s=58},  -- Calico Shoes
	[1497]={s=71},  -- Calico Cloak
	[1498]={s=57},  -- Calico Gloves
	[1499]={s=51},  -- Calico Pants
	[1501]={s=80},  -- Calico Tunic
	[1502]={s=60},  -- Warped Leather Belt
	[1503]={s=109},  -- Warped Leather Boots
	[1504]={s=32},  -- Warped Leather Bracers
	[1505]={s=48},  -- Warped Cloak
	[1506]={s=51},  -- Warped Leather Gloves
	[1507]={s=123},  -- Warped Leather Pants
	[1509]={s=59},  -- Warped Leather Vest
	[1510]={s=150},  -- Heavy Hammer
	[1511]={s=193},  -- Commoner's Sword
	[1512]={s=194},  -- Crude Battle Axe
	[1513]={s=293},  -- Old Greatsword
	[1514]={s=294},  -- Rusty Warhammer
	[1515]={s=196},  -- Rough Wooden Staff
	[1516]={s=237},  -- Worn Hatchet
	[1518]={s=0},  -- Ghost Hair Comb
	[1519]={s=0},  -- Bloodscalp Ear
	[1520]={s=71},  -- Troll Sweat
	[1521]={s=19205},  -- Lumbering Ogre Axe
	[1522]={s=10224},  -- Headhunting Spear
	[1523]={s=10261},  -- Huge Stone Club
	[1524]={s=0},  -- Skullsplitter Tusk
	[1528]={s=0},  -- Handful of Oats
	[1529]={s=700},  -- Jade
	[1532]={s=0},  -- Shrunken Head
	[1537]={s=62},  -- Old Blanchy's Feed Pouch
	[1539]={s=1572},  -- Gnarled Hermit's Staff
	[1547]={s=2795},  -- Shield of the Faith
	[1557]={s=918},  -- Buckler of the Seas
	[1560]={s=513},  -- Bluegill Sandals
	[1561]={s=268},  -- Harvester's Robe
	[1566]={s=1132},  -- Edge of the People's Militia
	[1596]={s=0},  -- Ghost Hair Thread
	[1598]={s=0},  -- Rot Blossom
	[1602]={s=11685},  -- Sickle Axe
	[1604]={s=19463},  -- Chromatic Sword
	[1607]={s=43420},  -- Soulkeeper
	[1608]={s=18940},  -- Skullcrusher Mace
	[1613]={s=19139},  -- Spiritchaser Staff
	[1624]={s=6172},  -- Skullsplitter Helm
	[1625]={s=14754},  -- Exquisite Flamberge
	[1630]={s=66},  -- Broken Electro-lantern
	[1637]={s=0},  -- Letter to Ello
	[1639]={s=28460},  -- Grinning Axe
	[1640]={s=15637},  -- Monstrous War Axe
	[1645]={s=100},  -- Moonberry Juice
	[1652]={s=5000},  -- Sturdy Lunchbox
	[1656]={s=0},  -- Translated Letter
	[1659]={s=2136},  -- Engineering Gloves
	[1664]={s=14695},  -- Spellforce Rod
	[1677]={s=10093},  -- Drake-scale Vest
	[1678]={s=4581},  -- Black Ogre Kickers
	[1679]={s=9635},  -- Korg Bat
	[1680]={s=18234},  -- Headchopper
	[1685]={s=6250},  -- Troll-hide Bag
	[1686]={s=733},  -- Bristly Whisker
	[1687]={s=243},  -- Retractable Claw
	[1688]={s=806},  -- Long Soft Tail
	[1696]={s=606},  -- Curved Raptor Talon
	[1697]={s=445},  -- Keen Raptor Tooth
	[1701]={s=376},  -- Curved Basilisk Claw
	[1702]={s=320},  -- Intact Basilisk Spine
	[1703]={s=81},  -- Crystal Basilisk Spine
	[1705]={s=600},  -- Lesser Moonstone
	[1706]={s=86},  -- Azuredeep Shards
	[1707]={s=62},  -- Stormwind Brie
	[1708]={s=50},  -- Sweet Nectar
	[1710]={s=125},  -- Greater Healing Potion
	[1711]={s=75},  -- Scroll of Stamina II
	[1712]={s=62},  -- Scroll of Spirit II
	[1713]={s=5350},  -- Ankh of Life
	[1714]={s=2535},  -- Necklace of Calisea
	[1715]={s=10301},  -- Polished Jazeraint Armor
	[1716]={s=5067},  -- Robe of the Magi
	[1717]={s=3108},  -- Double Link Tunic
	[1718]={s=8040},  -- Basilisk Hide Pants
	[1720]={s=26209},  -- Tanglewood Staff
	[1721]={s=35815},  -- Viking Warhammer
	[1722]={s=19407},  -- Thornstone Sledgehammer
	[1725]={s=5000},  -- Large Knapsack
	[1726]={s=12183},  -- Poison-tipped Bone Spear
	[1727]={s=4562},  -- Sword of Decay
	[1729]={s=500},  -- Gunnysack of the Night Watch
	[1730]={s=48},  -- Worn Mail Belt
	[1731]={s=92},  -- Worn Mail Boots
	[1732]={s=73},  -- Worn Mail Bracers
	[1733]={s=88},  -- Worn Cloak
	[1734]={s=39},  -- Worn Mail Gloves
	[1735]={s=89},  -- Worn Mail Pants
	[1737]={s=139},  -- Worn Mail Vest
	[1738]={s=147},  -- Laced Mail Belt
	[1739]={s=255},  -- Laced Mail Boots
	[1740]={s=97},  -- Laced Mail Bracers
	[1741]={s=112},  -- Laced Cloak
	[1742]={s=129},  -- Laced Mail Gloves
	[1743]={s=299},  -- Laced Mail Pants
	[1744]={s=260},  -- Laced Mail Shoulderpads
	[1745]={s=198},  -- Laced Mail Vest
	[1746]={s=332},  -- Linked Chain Belt
	[1747]={s=302},  -- Linked Chain Boots
	[1748]={s=232},  -- Linked Chain Bracers
	[1749]={s=396},  -- Linked Chain Cloak
	[1750]={s=298},  -- Linked Chain Gloves
	[1751]={s=676},  -- Linked Chain Pants
	[1752]={s=286},  -- Linked Chain Shoulderpads
	[1753]={s=439},  -- Linked Chain Vest
	[1754]={s=359},  -- Reinforced Chain Belt
	[1755]={s=597},  -- Reinforced Chain Boots
	[1756]={s=438},  -- Reinforced Chain Bracers
	[1757]={s=728},  -- Reinforced Chain Cloak
	[1758]={s=534},  -- Reinforced Chain Gloves
	[1759]={s=732},  -- Reinforced Chain Pants
	[1760]={s=609},  -- Reinforced Chain Shoulderpads
	[1761]={s=892},  -- Reinforced Chain Vest
	[1764]={s=113},  -- Canvas Shoes
	[1766]={s=131},  -- Canvas Cloak
	[1767]={s=101},  -- Canvas Gloves
	[1768]={s=217},  -- Canvas Pants
	[1769]={s=163},  -- Canvas Shoulderpads
	[1770]={s=143},  -- Canvas Vest
	[1772]={s=247},  -- Brocade Shoes
	[1774]={s=281},  -- Brocade Cloak
	[1775]={s=212},  -- Brocade Gloves
	[1776]={s=257},  -- Brocade Pants
	[1777]={s=222},  -- Brocade Shoulderpads
	[1778]={s=337},  -- Brocade Vest
	[1780]={s=489},  -- Cross-stitched Sandals
	[1782]={s=541},  -- Cross-stitched Cloak
	[1783]={s=247},  -- Cross-stitched Gloves
	[1784]={s=546},  -- Cross-stitched Pants
	[1785]={s=464},  -- Cross-stitched Shoulderpads
	[1786]={s=683},  -- Cross-stitched Vest
	[1787]={s=102},  -- Patched Leather Belt
	[1788]={s=176},  -- Patched Leather Boots
	[1789]={s=136},  -- Patched Leather Bracers
	[1790]={s=93},  -- Patched Cloak
	[1791]={s=90},  -- Patched Leather Gloves
	[1792]={s=208},  -- Patched Leather Pants
	[1793]={s=207},  -- Patched Leather Shoulderpads
	[1794]={s=277},  -- Patched Leather Jerkin
	[1795]={s=235},  -- Rawhide Belt
	[1796]={s=400},  -- Rawhide Boots
	[1797]={s=161},  -- Rawhide Bracers
	[1798]={s=279},  -- Rawhide Cloak
	[1799]={s=211},  -- Rawhide Gloves
	[1800]={s=479},  -- Rawhide Pants
	[1801]={s=418},  -- Rawhide Shoulderpads
	[1802]={s=337},  -- Rawhide Tunic
	[1803]={s=465},  -- Tough Leather Belt
	[1804]={s=478},  -- Tough Leather Boots
	[1805]={s=351},  -- Tough Leather Bracers
	[1806]={s=466},  -- Tough Cloak
	[1807]={s=387},  -- Tough Leather Gloves
	[1808]={s=856},  -- Tough Leather Pants
	[1809]={s=440},  -- Tough Leather Shoulderpads
	[1810]={s=648},  -- Tough Leather Armor
	[1811]={s=451},  -- Blunt Claymore
	[1812]={s=452},  -- Short-handled Battle Axe
	[1813]={s=522},  -- Chipped Quarterstaff
	[1814]={s=603},  -- Battered Mallet
	[1815]={s=366},  -- Ornamental Mace
	[1816]={s=486},  -- Unbalanced Axe
	[1817]={s=501},  -- Stock Shortsword
	[1818]={s=1221},  -- Standard Claymore
	[1819]={s=768},  -- Gouging Pick
	[1820]={s=963},  -- Wooden Maul
	[1821]={s=988},  -- Warped Blade
	[1822]={s=1096},  -- Cedar Walking Stick
	[1823]={s=779},  -- Bludgeoning Cudgel
	[1824]={s=1104},  -- Shiny War Axe
	[1825]={s=1548},  -- Bulky Bludgeon
	[1826]={s=1765},  -- Rock Maul
	[1827]={s=1282},  -- Meat Cleaver
	[1828]={s=1609},  -- Stone War Axe
	[1829]={s=1563},  -- Short Cutlass
	[1830]={s=1783},  -- Long Bastard Sword
	[1831]={s=1790},  -- Oaken War Staff
	[1832]={s=362},  -- Lucky Trousers
	[1835]={s=6},  -- Dirty Leather Belt
	[1836]={s=6},  -- Dirty Leather Bracers
	[1839]={s=36},  -- Rough Leather Belt
	[1840]={s=37},  -- Rough Leather Bracers
	[1843]={s=145},  -- Tanned Leather Belt
	[1844]={s=145},  -- Tanned Leather Bracers
	[1845]={s=175},  -- Chainmail Belt
	[1846]={s=176},  -- Chainmail Bracers
	[1849]={s=277},  -- Cured Leather Belt
	[1850]={s=278},  -- Cured Leather Bracers
	[1852]={s=336},  -- Scalemail Bracers
	[1853]={s=338},  -- Scalemail Belt
	[1875]={s=0},  -- Thistlenettle's Badge
	[1893]={s=1775},  -- Miner's Revenge
	[1894]={s=0},  -- Miners' Union Card
	[1913]={s=148},  -- Studded Blackjack
	[1917]={s=251},  -- Jeweled Dagger
	[1922]={s=0},  -- Supplies for Sven
	[1923]={s=0},  -- Ambassador's Satchel
	[1925]={s=787},  -- Defias Rapier
	[1926]={s=687},  -- Weighted Sap
	[1927]={s=690},  -- Deadmines Cleaver
	[1928]={s=995},  -- Defias Mage Staff
	[1929]={s=434},  -- Silk-threaded Trousers
	[1930]={s=408},  -- Stonemason Cloak
	[1931]={s=0},  -- Huge Gnoll Claw
	[1933]={s=905},  -- Staff of Conjuring
	[1934]={s=731},  -- Stonemason Trousers
	[1935]={s=2974},  -- Assassin's Blade
	[1936]={s=1113},  -- Goblin Screwdriver
	[1937]={s=1700},  -- Buzz Saw
	[1938]={s=1962},  -- Block Mallet
	[1939]={s=168},  -- Skin of Sweet Rum
	[1941]={s=203},  -- Cask of Merlot
	[1942]={s=316},  -- Bottle of Moonshine
	[1943]={s=713},  -- Goblin Mail Leggings
	[1944]={s=259},  -- Metalworking Gloves
	[1945]={s=267},  -- Woodworking Gloves
	[1946]={s=0},  -- Mary's Looking Glass
	[1951]={s=1258},  -- Blackwater Cutlass
	[1955]={s=1573},  -- Dragonmaw Chain Boots
	[1956]={s=0},  -- Faded Shadowhide Pendant
	[1958]={s=975},  -- Petrified Shinbone
	[1959]={s=1223},  -- Cold Iron Pick
	[1962]={s=0},  -- Glowing Shadowhide Pendant
	[1965]={s=36},  -- White Wolf Gloves
	[1968]={s=0},  -- Ogre's Monocle
	[1970]={s=120},  -- Restoring Balm
	[1971]={s=0},  -- Furlbrow's Deed
	[1972]={s=0},  -- Westfall Deed
	[1973]={s=4618},  -- Orb of Deception
	[1974]={s=464},  -- Mindthrust Bracers
	[1975]={s=5744},  -- Pysan's Old Greatsword
	[1976]={s=6340},  -- Slaghammer
	[1978]={s=980},  -- Wolfclaw Gloves
	[1979]={s=23273},  -- Wall of the Dead
	[1980]={s=6200},  -- Underworld Band
	[1981]={s=14113},  -- Icemail Jerkin
	[1982]={s=29513},  -- Nightblade
	[1986]={s=14861},  -- Gutrender
	[1987]={s=0},  -- Krazek's Fixed Pot
	[1988]={s=2852},  -- Chief Brigadier Gauntlets
	[1990]={s=10077},  -- Ballast Maul
	[1991]={s=8357},  -- Goblin Power Shovel
	[1992]={s=5468},  -- Swampchill Fetish
	[1993]={s=2100},  -- Ogremind Ring
	[1994]={s=16696},  -- Ebonclaw Reaver
	[1996]={s=1720},  -- Voodoo Band
	[1997]={s=2538},  -- Pressed Felt Robe
	[1998]={s=7239},  -- Bloodscalp Channeling Staff
	[2000]={s=8827},  -- Archeus
	[2004]={s=0},  -- Grelin Whitebeard's Journal
	[2005]={s=0},  -- The First Troll Legend
	[2006]={s=0},  -- The Second Troll Legend
	[2007]={s=0},  -- The Third Troll Legend
	[2008]={s=0},  -- The Fourth Troll Legend
	[2011]={s=3840},  -- Twisted Sabre
	[2013]={s=3644},  -- Cryptbone Staff
	[2014]={s=4869},  -- Black Metal Greatsword
	[2015]={s=4443},  -- Black Metal War Axe
	[2017]={s=895},  -- Glowing Leather Bracers
	[2018]={s=3269},  -- Skeletal Longsword
	[2020]={s=1049},  -- Hollowfang Blade
	[2021]={s=1025},  -- Green Carapace Shield
	[2024]={s=1215},  -- Espadon
	[2025]={s=1060},  -- Bearded Axe
	[2026]={s=1257},  -- Rock Hammer
	[2027]={s=763},  -- Scimitar
	[2028]={s=1013},  -- Hammer
	[2029]={s=883},  -- Cleaver
	[2030]={s=1108},  -- Gnarled Staff
	[2032]={s=1665},  -- Gallan Cuffs
	[2033]={s=967},  -- Ambassador's Boots
	[2034]={s=1035},  -- Scholarly Robes
	[2035]={s=2300},  -- Sword of the Night Sky
	[2036]={s=258},  -- Dusty Mining Gloves
	[2037]={s=469},  -- Tunneler's Boots
	[2039]={s=750},  -- Plains Ring
	[2041]={s=1412},  -- Tunic of Westfall
	[2042]={s=3639},  -- Staff of Westfall
	[2043]={s=1500},  -- Ring of Forlorn Spirits
	[2044]={s=7357},  -- Crescent of Forlorn Spirits
	[2046]={s=2461},  -- Bluegill Kukri
	[2047]={s=25},  -- Anvilmar Hand Axe
	[2048]={s=25},  -- Anvilmar Hammer
	[2054]={s=16},  -- Trogg Hand Axe
	[2055]={s=16},  -- Small Wooden Hammer
	[2057]={s=16},  -- Pitted Defias Shortsword
	[2058]={s=4197},  -- Kazon's Maul
	[2059]={s=863},  -- Sentry Cloak
	[2064]={s=191},  -- Trogg Club
	[2065]={s=113},  -- Rockjaw Blade
	[2066]={s=81},  -- Skull Hatchet
	[2067]={s=186},  -- Frostbit Staff
	[2069]={s=121},  -- Black Bear Hide Vest
	[2070]={s=1},  -- Darnassian Bleu
	[2072]={s=4414},  -- Dwarven Magestaff
	[2073]={s=742},  -- Dwarven Hatchet
	[2074]={s=1054},  -- Solid Shortblade
	[2075]={s=386},  -- Priest's Mace
	[2077]={s=5059},  -- Magician Staff
	[2078]={s=1070},  -- Northern Shortsword
	[2079]={s=933},  -- Sergeant's Warhammer
	[2080]={s=6590},  -- Hillborne Axe
	[2082]={s=250},  -- Wizbang's Gunnysack
	[2084]={s=5709},  -- Darksteel Bastard Sword
	[2085]={s=15},  -- Chunk of Flesh
	[2087]={s=252},  -- Hard Crawler Carapace
	[2088]={s=729},  -- Long Crawler Limb
	[2089]={s=1113},  -- Scrimshaw Dagger
	[2091]={s=213},  -- Magic Dust
	[2092]={s=7},  -- Worn Dagger
	[2098]={s=3020},  -- Double-barreled Shotgun
	[2099]={s=45040},  -- Dwarven Hand Cannon
	[2100]={s=24539},  -- Precisely Calibrated Boomstick
	[2101]={s=1},  -- Light Quiver
	[2102]={s=1},  -- Small Ammo Pouch
	[2105]={s=1},  -- Thug Shirt
	[2108]={s=8},  -- Frostmane Leather Vest
	[2109]={s=14},  -- Frostmane Chain Vest
	[2110]={s=6},  -- Light Magesmith Robe
	[2112]={s=54},  -- Lumberjack Jerkin
	[2113]={s=0},  -- Calor's Note
	[2114]={s=31},  -- Snowy Robe
	[2117]={s=7},  -- Thin Cloth Shoes
	[2119]={s=4},  -- Thin Cloth Gloves
	[2120]={s=10},  -- Thin Cloth Pants
	[2121]={s=10},  -- Thin Cloth Armor
	[2122]={s=6},  -- Cracked Leather Belt
	[2123]={s=9},  -- Cracked Leather Boots
	[2124]={s=6},  -- Cracked Leather Bracers
	[2125]={s=6},  -- Cracked Leather Gloves
	[2126]={s=11},  -- Cracked Leather Pants
	[2127]={s=12},  -- Cracked Leather Vest
	[2129]={s=15},  -- Large Round Shield
	[2130]={s=10},  -- Club
	[2131]={s=10},  -- Shortsword
	[2132]={s=20},  -- Short Staff
	[2133]={s=15},  -- Small Shield
	[2134]={s=16},  -- Hand Axe
	[2136]={s=0},  -- Conjured Purified Water
	[2137]={s=24},  -- Whittling Knife
	[2138]={s=38},  -- Sharpened Letter Opener
	[2139]={s=11},  -- Dirk
	[2140]={s=323},  -- Carving Knife
	[2141]={s=1044},  -- Cuirboulli Vest
	[2142]={s=524},  -- Cuirboulli Belt
	[2143]={s=788},  -- Cuirboulli Boots
	[2144]={s=527},  -- Cuirboulli Bracers
	[2145]={s=529},  -- Cuirboulli Gloves
	[2146]={s=961},  -- Cuirboulli Pants
	[2148]={s=581},  -- Polished Scale Belt
	[2149]={s=879},  -- Polished Scale Boots
	[2150]={s=586},  -- Polished Scale Bracers
	[2151]={s=588},  -- Polished Scale Gloves
	[2152]={s=1181},  -- Polished Scale Leggings
	[2153]={s=1185},  -- Polished Scale Vest
	[2154]={s=0},  -- The Story of Morgan Ladimore
	[2156]={s=615},  -- Padded Boots
	[2158]={s=413},  -- Padded Gloves
	[2159]={s=829},  -- Padded Pants
	[2160]={s=832},  -- Padded Armor
	[2161]={s=0},  -- Book from Sven's Farm
	[2162]={s=0},  -- Sarah's Ring
	[2163]={s=46710},  -- Shadowblade
	[2164]={s=27031},  -- Gut Ripper
	[2165]={s=45},  -- Old Blanchy's Blanket
	[2166]={s=810},  -- Foreman's Leggings
	[2167]={s=339},  -- Foreman's Gloves
	[2168]={s=469},  -- Foreman's Boots
	[2169]={s=943},  -- Buzzer Blade
	[2172]={s=7},  -- Rustic Belt
	[2173]={s=6},  -- Old Leather Belt
	[2175]={s=2683},  -- Shadowhide Battle Axe
	[2186]={s=6},  -- Outfitter Belt
	[2187]={s=0},  -- A Stack of Letters
	[2188]={s=0},  -- A Letter to Grelin Whitebeard
	[2194]={s=3276},  -- Diamond Hammer
	[2195]={s=25},  -- Anvilmar Knife
	[2203]={s=1492},  -- Brashclaw's Chopper
	[2204]={s=1133},  -- Brashclaw's Skewer
	[2205]={s=3961},  -- Duskbringer
	[2207]={s=478},  -- Jambiya
	[2208]={s=730},  -- Poniard
	[2209]={s=1423},  -- Kris
	[2210]={s=3},  -- Battered Buckler
	[2211]={s=7},  -- Bent Large Shield
	[2212]={s=16},  -- Cracked Buckler
	[2213]={s=24},  -- Worn Large Shield
	[2214]={s=182},  -- Wooden Buckler
	[2215]={s=81},  -- Wooden Shield
	[2216]={s=210},  -- Simple Buckler
	[2217]={s=243},  -- Rectangular Shield
	[2218]={s=501},  -- Craftsman's Dagger
	[2219]={s=457},  -- Small Round Shield
	[2220]={s=519},  -- Box Shield
	[2221]={s=910},  -- Targe Shield
	[2222]={s=1005},  -- Tower Shield
	[2223]={s=0},  -- The Collector's Schedule
	[2224]={s=24},  -- Militia Dagger
	[2225]={s=183},  -- Sharp Kitchen Knife
	[2226]={s=4117},  -- Ogremage Staff
	[2227]={s=4133},  -- Heavy Ogre War Axe
	[2230]={s=714},  -- Gloves of Brawn
	[2231]={s=4386},  -- Inferno Robe
	[2232]={s=812},  -- Dark Runner Boots
	[2233]={s=1690},  -- Shadow Weaver Leggings
	[2234]={s=1806},  -- Nightwalker Armor
	[2235]={s=1281},  -- Brackclaw
	[2236]={s=3386},  -- Blackfang
	[2237]={s=75},  -- Patched Pants
	[2238]={s=60},  -- Urchin's Pants
	[2239]={s=0},  -- The Collector's Ring
	[2240]={s=151},  -- Rugged Cape
	[2241]={s=615},  -- Desperado Cape
	[2243]={s=70554},  -- Hand of Edward the Odd
	[2244]={s=51857},  -- Krol Blade
	[2245]={s=27636},  -- Helm of Narv
	[2246]={s=30000},  -- Myrmidon's Signet
	[2249]={s=91},  -- Militia Buckler
	[2250]={s=0},  -- Dusky Crab Cakes
	[2251]={s=12},  -- Gooey Spider Leg
	[2252]={s=0},  -- Miscellaneous Goblin Supplies
	[2254]={s=506},  -- Icepane Warhammer
	[2256]={s=2996},  -- Skeletal Club
	[2257]={s=188},  -- Frostmane Staff
	[2258]={s=83},  -- Frostmane Shortsword
	[2259]={s=75},  -- Frostmane Club
	[2260]={s=106},  -- Frostmane Hand Axe
	[2262]={s=8746},  -- Mark of Kern
	[2263]={s=2619},  -- Phytoblade
	[2264]={s=1957},  -- Mantle of Thieves
	[2265]={s=477},  -- Stonesplinter Axe
	[2266]={s=479},  -- Stonesplinter Dagger
	[2267]={s=711},  -- Stonesplinter Mace
	[2268]={s=146},  -- Stonesplinter Blade
	[2271]={s=3255},  -- Staff of the Blessed Seer
	[2274]={s=289},  -- Sapper's Gloves
	[2276]={s=4093},  -- Swampwalker Boots
	[2277]={s=3620},  -- Necromancer Leggings
	[2278]={s=2326},  -- Forest Tracker Epaulets
	[2280]={s=4023},  -- Kam's Walking Stick
	[2281]={s=300},  -- Rodentia Flint Axe
	[2282]={s=139},  -- Rodentia Shortsword
	[2283]={s=140},  -- Rat Cloth Belt
	[2284]={s=211},  -- Rat Cloth Cloak
	[2287]={s=6},  -- Haunch of Meat
	[2288]={s=0},  -- Conjured Fresh Water
	[2289]={s=87},  -- Scroll of Strength II
	[2290]={s=75},  -- Scroll of Intellect II
	[2291]={s=44580},  -- Kang the Decapitator
	[2292]={s=1334},  -- Necrology Robes
	[2295]={s=70},  -- Large Boar Tusk
	[2296]={s=50},  -- Great Goretusk Snout
	[2299]={s=8756},  -- Burning War Axe
	[2300]={s=192},  -- Embossed Leather Vest
	[2302]={s=29},  -- Handstitched Leather Boots
	[2303]={s=71},  -- Handstitched Leather Pants
	[2304]={s=15},  -- Light Armor Kit
	[2307]={s=243},  -- Fine Leather Boots
	[2308]={s=267},  -- Fine Leather Cloak
	[2309]={s=268},  -- Embossed Leather Boots
	[2310]={s=112},  -- Embossed Leather Cloak
	[2311]={s=150},  -- White Leather Jerkin
	[2312]={s=181},  -- Fine Leather Gloves
	[2313]={s=200},  -- Medium Armor Kit
	[2314]={s=743},  -- Toughened Leather Armor
	[2315]={s=307},  -- Dark Leather Boots
	[2316]={s=408},  -- Dark Leather Cloak
	[2317]={s=689},  -- Dark Leather Tunic
	[2318]={s=15},  -- Light Leather
	[2319]={s=50},  -- Medium Leather
	[2320]={s=2},  -- Coarse Thread
	[2321]={s=25},  -- Fine Thread
	[2324]={s=6},  -- Bleach
	[2325]={s=250},  -- Black Dye
	[2326]={s=29},  -- Ivy-weave Bracers
	[2327]={s=36},  -- Sturdy Leather Bracers
	[2361]={s=9},  -- Battleworn Hammer
	[2362]={s=1},  -- Worn Wooden Shield
	[2364]={s=59},  -- Woven Vest
	[2366]={s=59},  -- Woven Pants
	[2367]={s=44},  -- Woven Boots
	[2369]={s=30},  -- Woven Gloves
	[2370]={s=75},  -- Battered Leather Harness
	[2371]={s=37},  -- Battered Leather Belt
	[2372]={s=68},  -- Battered Leather Pants
	[2373]={s=51},  -- Battered Leather Boots
	[2374]={s=34},  -- Battered Leather Bracers
	[2375]={s=34},  -- Battered Leather Gloves
	[2376]={s=89},  -- Worn Heater Shield
	[2378]={s=0},  -- Skeleton Finger
	[2379]={s=15},  -- Tarnished Chain Vest
	[2380]={s=7},  -- Tarnished Chain Belt
	[2381]={s=15},  -- Tarnished Chain Leggings
	[2382]={s=0},  -- The Embalmer's Heart
	[2383]={s=11},  -- Tarnished Chain Boots
	[2384]={s=7},  -- Tarnished Chain Bracers
	[2385]={s=7},  -- Tarnished Chain Gloves
	[2386]={s=15},  -- Rusted Chain Vest
	[2387]={s=7},  -- Rusted Chain Belt
	[2388]={s=15},  -- Rusted Chain Leggings
	[2389]={s=11},  -- Rusted Chain Boots
	[2390]={s=7},  -- Rusted Chain Bracers
	[2391]={s=7},  -- Rusted Chain Gloves
	[2392]={s=82},  -- Light Mail Armor
	[2393]={s=41},  -- Light Mail Belt
	[2394]={s=83},  -- Light Mail Leggings
	[2395]={s=64},  -- Light Mail Boots
	[2396]={s=43},  -- Light Mail Bracers
	[2397]={s=43},  -- Light Mail Gloves
	[2398]={s=86},  -- Light Chain Armor
	[2399]={s=43},  -- Light Chain Belt
	[2400]={s=87},  -- Light Chain Leggings
	[2401]={s=66},  -- Light Chain Boots
	[2402]={s=43},  -- Light Chain Bracers
	[2403]={s=44},  -- Light Chain Gloves
	[2406]={s=25},  -- Pattern: Fine Leather Boots
	[2407]={s=162},  -- Pattern: White Leather Jerkin
	[2408]={s=125},  -- Pattern: Fine Leather Gloves
	[2409]={s=350},  -- Pattern: Dark Leather Tunic
	[2411]={s=0},  -- Black Stallion Bridle
	[2414]={s=0},  -- Pinto Bridle
	[2417]={s=3134},  -- Augmented Chain Vest
	[2418]={s=3146},  -- Augmented Chain Leggings
	[2419]={s=1578},  -- Augmented Chain Belt
	[2420]={s=2387},  -- Augmented Chain Boots
	[2421]={s=1590},  -- Augmented Chain Bracers
	[2422]={s=1596},  -- Augmented Chain Gloves
	[2423]={s=8554},  -- Brigandine Vest
	[2424]={s=4292},  -- Brigandine Belt
	[2425]={s=8615},  -- Brigandine Leggings
	[2426]={s=6513},  -- Brigandine Boots
	[2427]={s=4029},  -- Brigandine Bracers
	[2428]={s=4044},  -- Brigandine Gloves
	[2429]={s=2027},  -- Russet Vest
	[2431]={s=2043},  -- Russet Pants
	[2432]={s=1538},  -- Russet Boots
	[2434]={s=1033},  -- Russet Gloves
	[2435]={s=5536},  -- Embroidered Armor
	[2437]={s=5578},  -- Embroidered Pants
	[2438]={s=4199},  -- Embroidered Boots
	[2440]={s=2819},  -- Embroidered Gloves
	[2445]={s=686},  -- Large Metal Shield
	[2446]={s=1236},  -- Kite Shield
	[2447]={s=10},  -- Peacebloom
	[2448]={s=3231},  -- Heavy Pavise
	[2449]={s=20},  -- Earthroot
	[2450]={s=25},  -- Briarthorn
	[2451]={s=8725},  -- Crested Heater Shield
	[2452]={s=15},  -- Swiftthistle
	[2453]={s=25},  -- Bruiseweed
	[2454]={s=20},  -- Elixir of Lion's Strength
	[2455]={s=10},  -- Minor Mana Potion
	[2456]={s=15},  -- Minor Rejuvenation Potion
	[2457]={s=15},  -- Elixir of Minor Agility
	[2458]={s=15},  -- Elixir of Minor Fortitude
	[2459]={s=25},  -- Swiftness Potion
	[2463]={s=2739},  -- Studded Doublet
	[2464]={s=1374},  -- Studded Belt
	[2465]={s=2495},  -- Studded Pants
	[2466]={s=0},  -- Skullsplitter Fetish
	[2467]={s=1886},  -- Studded Boots
	[2468]={s=1262},  -- Studded Bracers
	[2469]={s=1266},  -- Studded Gloves
	[2470]={s=6790},  -- Reinforced Leather Vest
	[2471]={s=3408},  -- Reinforced Leather Belt
	[2472]={s=6842},  -- Reinforced Leather Pants
	[2473]={s=5150},  -- Reinforced Leather Boots
	[2474]={s=3446},  -- Reinforced Leather Bracers
	[2475]={s=3459},  -- Reinforced Leather Gloves
	[2476]={s=0},  -- Chilled Basilisk Haunch
	[2477]={s=0},  -- Ravager's Skull
	[2479]={s=21},  -- Broad Axe
	[2480]={s=14},  -- Large Club
	[2488]={s=107},  -- Gladius
	[2489]={s=68},  -- Two-handed Sword
	[2490]={s=108},  -- Tomahawk
	[2491]={s=96},  -- Large Axe
	[2492]={s=56},  -- Cudgel
	[2493]={s=140},  -- Wooden Mallet
	[2494]={s=80},  -- Stiletto
	[2495]={s=100},  -- Walking Stick
	[2504]={s=5},  -- Worn Shortbow
	[2505]={s=11},  -- Polished Shortbow
	[2506]={s=57},  -- Hornwood Recurve Bow
	[2507]={s=350},  -- Laminated Recurve Bow
	[2508]={s=5},  -- Old Blunderbuss
	[2509]={s=82},  -- Ornate Blunderbuss
	[2510]={s=8},  -- Solid Blunderbuss
	[2511]={s=264},  -- Hunter's Boomstick
	[2512]={s=0},  -- Rough Arrow
	[2515]={s=0},  -- Sharp Arrow
	[2516]={s=0},  -- Light Shot
	[2519]={s=0},  -- Heavy Shot
	[2520]={s=4925},  -- Broadsword
	[2521]={s=6179},  -- Flamberge
	[2522]={s=4509},  -- Crescent Axe
	[2523]={s=5657},  -- Bullova
	[2524]={s=3838},  -- Truncheon
	[2525]={s=5297},  -- War Hammer
	[2526]={s=3867},  -- Main Gauche
	[2527]={s=5871},  -- Battle Staff
	[2528]={s=10367},  -- Falchion
	[2529]={s=13006},  -- Zweihander
	[2530]={s=10443},  -- Francisca
	[2531]={s=11233},  -- Great Axe
	[2532]={s=10521},  -- Morning Star
	[2533]={s=12221},  -- War Maul
	[2534]={s=9086},  -- Rondel
	[2535]={s=12311},  -- War Staff
	[2536]={s=0},  -- Trogg Stone Tooth
	[2545]={s=1796},  -- Malleable Chain Leggings
	[2546]={s=55},  -- Royal Frostmane Girdle
	[2547]={s=7},  -- Boar Handler Gloves
	[2548]={s=0},  -- Barrel of Barleybrew Scalder
	[2549]={s=5016},  -- Staff of the Shade
	[2553]={s=25},  -- Recipe: Elixir of Minor Agility
	[2555]={s=40},  -- Recipe: Swiftness Potion
	[2560]={s=0},  -- Jitters' Completed Journal
	[2561]={s=0},  -- Chok'sul's Head
	[2562]={s=575},  -- Bouquet of Scarlet Begonias
	[2563]={s=0},  -- Strange Smelling Powder
	[2564]={s=6817},  -- Elven Spirit Claws
	[2565]={s=3113},  -- Rod of Molten Fire
	[2566]={s=1322},  -- Sacrificial Robes
	[2567]={s=2509},  -- Evocator's Blade
	[2568]={s=31},  -- Brown Linen Vest
	[2569]={s=87},  -- Linen Boots
	[2570]={s=11},  -- Linen Cloak
	[2571]={s=16},  -- Viny Wrappings
	[2572]={s=99},  -- Red Linen Robe
	[2575]={s=25},  -- Red Linen Shirt
	[2576]={s=75},  -- White Linen Shirt
	[2577]={s=75},  -- Blue Linen Shirt
	[2578]={s=224},  -- Barbaric Linen Vest
	[2579]={s=37},  -- Green Linen Shirt
	[2580]={s=67},  -- Reinforced Linen Cape
	[2581]={s=20},  -- Heavy Linen Bandage
	[2582]={s=216},  -- Green Woolen Vest
	[2583]={s=359},  -- Woolen Boots
	[2584]={s=142},  -- Woolen Cape
	[2585]={s=638},  -- Gray Woolen Robe
	[2586]={s=1},  -- Gamemaster's Robe
	[2587]={s=200},  -- Gray Woolen Shirt
	[2589]={s=13},  -- Linen Cloth
	[2590]={s=5},  -- Forest Spider Webbing
	[2591]={s=5},  -- Dirty Trogg Cloth
	[2592]={s=33},  -- Wool Cloth
	[2593]={s=37},  -- Flask of Port
	[2594]={s=375},  -- Flagon of Mead
	[2595]={s=500},  -- Jug of Bourbon
	[2596]={s=30},  -- Skin of Dwarven Stout
	[2598]={s=30},  -- Pattern: Red Linen Robe
	[2601]={s=100},  -- Pattern: Gray Woolen Robe
	[2604]={s=12},  -- Red Dye
	[2605]={s=25},  -- Green Dye
	[2606]={s=0},  -- Lurker Venom
	[2607]={s=0},  -- Mo'grosh Crystal
	[2608]={s=63},  -- Threshadon Ambergris
	[2609]={s=0},  -- Disarming Colloid
	[2610]={s=0},  -- Disarming Mixture
	[2611]={s=0},  -- Crude Flint
	[2612]={s=32},  -- Plain Robe
	[2613]={s=121},  -- Double-stitched Robes
	[2614]={s=232},  -- Robe of Apprenticeship
	[2615]={s=1018},  -- Chromatic Robe
	[2616]={s=531},  -- Shimmering Silk Robes
	[2617]={s=2198},  -- Burning Robes
	[2618]={s=5327},  -- Silver Dress Robes
	[2619]={s=0},  -- Grelin's Report
	[2620]={s=3013},  -- Augural Shroud
	[2621]={s=2357},  -- Cowl of Necromancy
	[2622]={s=2603},  -- Nimar's Tribal Headdress
	[2623]={s=3554},  -- Holy Diadem
	[2624]={s=3852},  -- Thinking Cap
	[2625]={s=0},  -- Menethil Statuette
	[2628]={s=0},  -- Senir's Report
	[2629]={s=0},  -- Intrepid Strongbox Key
	[2632]={s=605},  -- Curved Dagger
	[2633]={s=25},  -- Jungle Remedy
	[2634]={s=0},  -- Venom Fern Extract
	[2635]={s=16},  -- Loose Chain Belt
	[2636]={s=0},  -- Carved Stone Idol
	[2637]={s=0},  -- Ironband's Progress Report
	[2639]={s=0},  -- Merrin's Letter
	[2640]={s=0},  -- Miners' Gear
	[2642]={s=33},  -- Loose Chain Boots
	[2643]={s=28},  -- Loose Chain Bracers
	[2644]={s=11},  -- Loose Chain Cloak
	[2645]={s=11},  -- Loose Chain Gloves
	[2646]={s=31},  -- Loose Chain Pants
	[2648]={s=58},  -- Loose Chain Vest
	[2649]={s=1},  -- Flimsy Chain Belt
	[2650]={s=3},  -- Flimsy Chain Boots
	[2651]={s=3},  -- Flimsy Chain Bracers
	[2652]={s=7},  -- Flimsy Chain Cloak
	[2653]={s=3},  -- Flimsy Chain Gloves
	[2654]={s=2},  -- Flimsy Chain Pants
	[2656]={s=9},  -- Flimsy Chain Vest
	[2657]={s=875},  -- Red Leather Bag
	[2658]={s=0},  -- Ados Fragment
	[2659]={s=0},  -- Modr Fragment
	[2660]={s=0},  -- Golm Fragment
	[2661]={s=0},  -- Neru Fragment
	[2662]={s=8750},  -- Ribbly's Quiver
	[2663]={s=8750},  -- Ribbly's Bandolier
	[2665]={s=5},  -- Stormwind Seasoning Herbs
	[2666]={s=0},  -- Barrel of Thunder Ale
	[2667]={s=0},  -- MacGrann's Dried Meats
	[2671]={s=0},  -- Wendigo Mane
	[2672]={s=4},  -- Stringy Wolf Meat
	[2673]={s=10},  -- Coyote Meat
	[2674]={s=12},  -- Crawler Meat
	[2675]={s=11},  -- Crawler Claw
	[2676]={s=0},  -- Shimmerweed
	[2677]={s=15},  -- Boar Ribs
	[2678]={s=0},  -- Mild Spices
	[2679]={s=5},  -- Charred Wolf Meat
	[2680]={s=10},  -- Spiced Wolf Meat
	[2681]={s=6},  -- Roasted Boar Meat
	[2682]={s=25},  -- Cooked Crab Claw
	[2683]={s=25},  -- Crab Cake
	[2684]={s=20},  -- Coyote Steak
	[2685]={s=75},  -- Succulent Pork Ribs
	[2686]={s=12},  -- Thunder Ale
	[2687]={s=25},  -- Dry Pork Ribs
	[2690]={s=7},  -- Latched Belt
	[2691]={s=10},  -- Outfitter Boots
	[2692]={s=10},  -- Hot Spices
	[2694]={s=539},  -- Settler's Leggings
	[2696]={s=0},  -- Cask of Evershine
	[2697]={s=100},  -- Recipe: Goretusk Liver Pie
	[2698]={s=100},  -- Recipe: Cooked Crab Claw
	[2699]={s=200},  -- Recipe: Redridge Goulash
	[2700]={s=100},  -- Recipe: Succulent Pork Ribs
	[2701]={s=400},  -- Recipe: Seasoned Wolf Kabob
	[2702]={s=0},  -- Lightforge Ingot
	[2712]={s=0},  -- Crate of Lightforge Ingots
	[2713]={s=0},  -- Ol' Sooty's Head
	[2719]={s=0},  -- Small Brass Key
	[2720]={s=0},  -- Muddy Note
	[2721]={s=1982},  -- Holy Shroud
	[2722]={s=0},  -- Wine Ticket
	[2723]={s=12},  -- Bottle of Pinot Noir
	[2724]={s=0},  -- Cloth Request
	[2725]={s=375},  -- Green Hills of Stranglethorn - Page 1
	[2728]={s=375},  -- Green Hills of Stranglethorn - Page 4
	[2730]={s=375},  -- Green Hills of Stranglethorn - Page 6
	[2732]={s=375},  -- Green Hills of Stranglethorn - Page 8
	[2734]={s=375},  -- Green Hills of Stranglethorn - Page 10
	[2735]={s=375},  -- Green Hills of Stranglethorn - Page 11
	[2738]={s=375},  -- Green Hills of Stranglethorn - Page 14
	[2740]={s=375},  -- Green Hills of Stranglethorn - Page 16
	[2742]={s=375},  -- Green Hills of Stranglethorn - Page 18
	[2744]={s=375},  -- Green Hills of Stranglethorn - Page 20
	[2745]={s=375},  -- Green Hills of Stranglethorn - Page 21
	[2748]={s=375},  -- Green Hills of Stranglethorn - Page 24
	[2749]={s=375},  -- Green Hills of Stranglethorn - Page 25
	[2750]={s=375},  -- Green Hills of Stranglethorn - Page 26
	[2751]={s=375},  -- Green Hills of Stranglethorn - Page 27
	[2754]={s=13},  -- Tarnished Bastard Sword
	[2756]={s=0},  -- Green Hills of Stranglethorn - Chapter I
	[2757]={s=0},  -- Green Hills of Stranglethorn - Chapter II
	[2758]={s=0},  -- Green Hills of Stranglethorn - Chapter III
	[2759]={s=0},  -- Green Hills of Stranglethorn - Chapter IV
	[2760]={s=0},  -- Thurman's Sewing Kit
	[2763]={s=240},  -- Fisherman Knife
	[2764]={s=440},  -- Small Dagger
	[2765]={s=811},  -- Hunting Knife
	[2766]={s=1564},  -- Deft Stiletto
	[2770]={s=5},  -- Copper Ore
	[2771]={s=25},  -- Tin Ore
	[2772]={s=150},  -- Iron Ore
	[2773]={s=39},  -- Cracked Shortbow
	[2774]={s=28},  -- Rust-covered Blunderbuss
	[2775]={s=75},  -- Silver Ore
	[2776]={s=500},  -- Gold Ore
	[2777]={s=146},  -- Feeble Shortbow
	[2778]={s=147},  -- Cheap Blunderbuss
	[2779]={s=0},  -- Tear of Tilloa
	[2780]={s=374},  -- Light Hunting Bow
	[2781]={s=335},  -- Dirty Blunderbuss
	[2782]={s=751},  -- Mishandled Recurve Bow
	[2783]={s=590},  -- Shoddy Blunderbuss
	[2784]={s=0},  -- Musquash Root
	[2785]={s=1062},  -- Stiff Recurve Bow
	[2786]={s=1173},  -- Oiled Blunderbuss
	[2787]={s=10},  -- Trogg Dagger
	[2788]={s=0},  -- Black Claw Stout
	[2794]={s=0},  -- An Old History Book
	[2795]={s=0},  -- Book: Stresses of Iron
	[2797]={s=0},  -- Heart of Mokk
	[2798]={s=0},  -- Rethban Ore
	[2799]={s=67},  -- Gorilla Fang
	[2800]={s=1525},  -- Black Velvet Robes
	[2801]={s=104729},  -- Blade of Hanna
	[2802]={s=1625},  -- Blazing Emblem
	[2805]={s=2352},  -- Yeti Fur Cloak
	[2806]={s=0},  -- Package for Stormpike
	[2807]={s=2452},  -- Guillotine Axe
	[2815]={s=19778},  -- Curve-bladed Ripper
	[2816]={s=7324},  -- Death Speaker Scepter
	[2817]={s=201},  -- Soft Leather Tunic
	[2818]={s=363},  -- Stretched Leather Trousers
	[2819]={s=3830},  -- Cross Dagger
	[2820]={s=4662},  -- Nifty Stopwatch
	[2821]={s=1117},  -- Mo'grosh Masher
	[2822]={s=1402},  -- Mo'grosh Toothpick
	[2823]={s=1618},  -- Mo'grosh Can Opener
	[2824]={s=32031},  -- Hurricane
	[2825]={s=14721},  -- Bow of Searing Arrows
	[2828]={s=0},  -- Nissa's Remains
	[2829]={s=0},  -- Gregor's Remains
	[2830]={s=0},  -- Thurman's Remains
	[2831]={s=0},  -- Devlin's Remains
	[2832]={s=0},  -- Verna's Westfall Stew Recipe
	[2833]={s=0},  -- The Lich's Spellbook
	[2834]={s=0},  -- Embalming Ichor
	[2835]={s=2},  -- Rough Stone
	[2836]={s=15},  -- Coarse Stone
	[2837]={s=0},  -- Thurman's Letter
	[2838]={s=60},  -- Heavy Stone
	[2839]={s=0},  -- A Letter to Yvette
	[2840]={s=10},  -- Copper Bar
	[2841]={s=50},  -- Bronze Bar
	[2842]={s=100},  -- Silver Bar
	[2843]={s=0},  -- Dirty Knucklebones
	[2844]={s=106},  -- Copper Mace
	[2845]={s=109},  -- Copper Axe
	[2846]={s=0},  -- Tirisfal Pumpkin
	[2847]={s=110},  -- Copper Shortsword
	[2848]={s=1119},  -- Bronze Mace
	[2849]={s=1269},  -- Bronze Axe
	[2850]={s=1439},  -- Bronze Shortsword
	[2851]={s=56},  -- Copper Chain Belt
	[2852]={s=67},  -- Copper Chain Pants
	[2853]={s=17},  -- Copper Bracers
	[2854]={s=225},  -- Runed Copper Bracers
	[2855]={s=0},  -- Putrid Claw
	[2856]={s=0},  -- Iron Pike
	[2857]={s=198},  -- Runed Copper Belt
	[2858]={s=0},  -- Darkhound Blood
	[2859]={s=0},  -- Vile Fin Scale
	[2862]={s=3},  -- Rough Sharpening Stone
	[2863]={s=10},  -- Coarse Sharpening Stone
	[2864]={s=630},  -- Runed Copper Breastplate
	[2865]={s=962},  -- Rough Bronze Leggings
	[2866]={s=752},  -- Rough Bronze Cuirass
	[2868]={s=807},  -- Patterned Bronze Bracers
	[2869]={s=1831},  -- Silvered Bronze Breastplate
	[2870]={s=2935},  -- Shining Silver Breastplate
	[2871]={s=40},  -- Heavy Sharpening Stone
	[2872]={s=0},  -- Vicious Night Web Spider Venom
	[2874]={s=0},  -- An Unsent Letter
	[2875]={s=0},  -- Scarlet Insignia Ring
	[2876]={s=0},  -- Duskbat Pelt
	[2877]={s=8524},  -- Combatant Claymore
	[2878]={s=5143},  -- Bearded Boneaxe
	[2879]={s=3121},  -- Antipodean Rod
	[2880]={s=25},  -- Weak Flux
	[2881]={s=150},  -- Plans: Runed Copper Breastplate
	[2882]={s=300},  -- Plans: Silvered Bronze Shoulders
	[2883]={s=375},  -- Plans: Deadly Bronze Poniard
	[2885]={s=0},  -- Scarlet Crusade Documents
	[2886]={s=5},  -- Crag Boar Rib
	[2888]={s=10},  -- Beer Basted Boar Ribs
	[2889]={s=60},  -- Recipe: Beer Basted Boar Ribs
	[2892]={s=30},  -- Deadly Poison
	[2893]={s=55},  -- Deadly Poison II
	[2894]={s=12},  -- Rhapsody Malt
	[2898]={s=32},  -- Mountaineer Chestpiece
	[2899]={s=169},  -- Wendigo Collar
	[2900]={s=89},  -- Stone Buckler
	[2901]={s=16},  -- Mining Pick
	[2902]={s=1305},  -- Cloak of the Faith
	[2903]={s=515},  -- Daryl's Hunting Bow
	[2904]={s=595},  -- Daryl's Hunting Rifle
	[2905]={s=53},  -- Goat Fur Cloak
	[2906]={s=1810},  -- Darkshire Mail Leggings
	[2907]={s=1755},  -- Dwarven Tree Chopper
	[2908]={s=1409},  -- Thornblade
	[2909]={s=0},  -- Red Wool Bandana
	[2910]={s=1257},  -- Gold Militia Boots
	[2911]={s=524},  -- Keller's Girdle
	[2912]={s=6731},  -- Claw of the Shadowmancer
	[2913]={s=1153},  -- Silk Mantle of Gamn
	[2915]={s=55289},  -- Taran Icebreaker
	[2916]={s=4405},  -- Gold Lion Shield
	[2917]={s=665},  -- Tranquil Ring
	[2924]={s=16},  -- Crocolisk Meat
	[2925]={s=0},  -- Crocolisk Skin
	[2926]={s=0},  -- Head of Bazil Thredd
	[2928]={s=5},  -- Dust of Decay
	[2930]={s=12},  -- Essence of Pain
	[2933]={s=3750},  -- Seal of Wrynn
	[2934]={s=7},  -- Ruined Leather Scraps
	[2939]={s=0},  -- Crocolisk Tear
	[2940]={s=43},  -- Bloody Bear Paw
	[2941]={s=3552},  -- Prison Shank
	[2942]={s=3663},  -- Iron Knuckles
	[2943]={s=537},  -- Eye of Paleth
	[2944]={s=0},  -- Cursed Eye of Paleth
	[2946]={s=0},  -- Balanced Throwing Dagger
	[2947]={s=0},  -- Small Throwing Knife
	[2949]={s=1039},  -- Mariner Boots
	[2950]={s=3476},  -- Icicle Rod
	[2951]={s=656},  -- Ring of the Underwood
	[2953]={s=2321},  -- Watch Master's Cloak
	[2954]={s=2485},  -- Night Watch Pantaloons
	[2955]={s=3449},  -- First Mate Hat
	[2956]={s=0},  -- Report on the Defias Brotherhood
	[2957]={s=119},  -- Journeyman's Vest
	[2958]={s=94},  -- Journeyman's Pants
	[2959]={s=32},  -- Journeyman's Boots
	[2960]={s=21},  -- Journeyman's Gloves
	[2961]={s=155},  -- Burnt Leather Vest
	[2962]={s=120},  -- Burnt Leather Breeches
	[2963]={s=41},  -- Burnt Leather Boots
	[2964]={s=36},  -- Burnt Leather Gloves
	[2965]={s=189},  -- Warrior's Tunic
	[2966]={s=146},  -- Warrior's Pants
	[2967]={s=66},  -- Warrior's Boots
	[2968]={s=33},  -- Warrior's Gloves
	[2969]={s=381},  -- Spellbinder Vest
	[2970]={s=333},  -- Spellbinder Pants
	[2971]={s=108},  -- Spellbinder Boots
	[2972]={s=72},  -- Spellbinder Gloves
	[2973]={s=484},  -- Hunting Tunic
	[2974]={s=392},  -- Hunting Pants
	[2975]={s=128},  -- Hunting Boots
	[2976]={s=171},  -- Hunting Gloves
	[2977]={s=476},  -- Veteran Armor
	[2978]={s=415},  -- Veteran Leggings
	[2979]={s=157},  -- Veteran Boots
	[2980]={s=209},  -- Veteran Gloves
	[2981]={s=648},  -- Seer's Robe
	[2982]={s=565},  -- Seer's Pants
	[2983]={s=280},  -- Seer's Boots
	[2984]={s=215},  -- Seer's Gloves
	[2985]={s=822},  -- Inscribed Leather Breastplate
	[2986]={s=718},  -- Inscribed Leather Pants
	[2987]={s=408},  -- Inscribed Leather Boots
	[2988]={s=314},  -- Inscribed Leather Gloves
	[2989]={s=1001},  -- Burnished Tunic
	[2990]={s=933},  -- Burnished Leggings
	[2991]={s=705},  -- Burnished Boots
	[2992]={s=408},  -- Burnished Gloves
	[2996]={s=40},  -- Bolt of Linen Cloth
	[2997]={s=100},  -- Bolt of Woolen Cloth
	[2998]={s=0},  -- A Simple Compass
	[2999]={s=0},  -- Steelgrill's Tools
	[3000]={s=119},  -- Brood Mother Carapace
	[3008]={s=43},  -- Wendigo Fur Cloak
	[3010]={s=101},  -- Fine Sand
	[3011]={s=2846},  -- Feathered Headdress
	[3012]={s=50},  -- Scroll of Agility
	[3013]={s=25},  -- Scroll of Protection
	[3014]={s=0},  -- Battleworn Axe
	[3016]={s=0},  -- Gunther's Spellbook
	[3017]={s=0},  -- Sevren's Orders
	[3018]={s=781},  -- Hide of Lupos
	[3019]={s=423},  -- Noble's Robe
	[3020]={s=2655},  -- Enduring Cap
	[3021]={s=2421},  -- Ranger Bow
	[3022]={s=1085},  -- Bluegill Breeches
	[3023]={s=754},  -- Large Bore Blunderbuss
	[3024]={s=1419},  -- BKP 2700 "Enforcer"
	[3025]={s=3695},  -- BKP 42 "Ultra"
	[3026]={s=762},  -- Reinforced Bow
	[3027]={s=1269},  -- Heavy Recurve Bow
	[3030]={s=0},  -- Razor Arrow
	[3033]={s=0},  -- Solid Shot
	[3035]={s=0},  -- Laced Pumpkin
	[3036]={s=515},  -- Heavy Shortbow
	[3037]={s=4814},  -- Whipwood Recurve Bow
	[3039]={s=1610},  -- Short Ash Bow
	[3040]={s=940},  -- Hunter's Muzzle Loader
	[3041]={s=3769},  -- "Mage-Eye" Blunderbuss
	[3042]={s=4577},  -- BKP "Sparrow" Smallbore
	[3045]={s=1573},  -- Lambent Scale Boots
	[3047]={s=1052},  -- Lambent Scale Gloves
	[3048]={s=1919},  -- Lambent Scale Legguards
	[3049]={s=2119},  -- Lambent Scale Breastplate
	[3053]={s=2140},  -- Humbert's Chestpiece
	[3055]={s=1526},  -- Forest Leather Chestpiece
	[3056]={s=1532},  -- Forest Leather Pants
	[3057]={s=903},  -- Forest Leather Boots
	[3058]={s=682},  -- Forest Leather Gloves
	[3065]={s=658},  -- Bright Boots
	[3066]={s=497},  -- Bright Gloves
	[3067]={s=1275},  -- Bright Pants
	[3069]={s=1412},  -- Bright Robe
	[3070]={s=11},  -- Ensign Cloak
	[3071]={s=231},  -- Striking Hatchet
	[3072]={s=1207},  -- Smoldering Robe
	[3073]={s=1211},  -- Smoldering Pants
	[3074]={s=476},  -- Smoldering Gloves
	[3075]={s=15073},  -- Eye of Flame
	[3076]={s=636},  -- Smoldering Boots
	[3078]={s=2314},  -- Naga Heartpiercer
	[3079]={s=297},  -- Skorn's Rifle
	[3080]={s=0},  -- Candle of Beckoning
	[3081]={s=0},  -- Nether Gem
	[3082]={s=0},  -- Dargol's Skull
	[3083]={s=0},  -- Restabilization Cog
	[3084]={s=0},  -- Gyromechanic Gear
	[3085]={s=0},  -- Barrel of Shimmer Stout
	[3086]={s=0},  -- Cask of Shimmer Stout
	[3087]={s=11},  -- Mug of Shimmer Stout
	[3103]={s=466},  -- Coldridge Hammer
	[3107]={s=0},  -- Keen Throwing Knife
	[3108]={s=0},  -- Heavy Throwing Dagger
	[3110]={s=0},  -- Tunnel Rat Ear
	[3111]={s=0},  -- Crude Throwing Axe
	[3117]={s=0},  -- Hildelve's Journal
	[3131]={s=0},  -- Weighted Throwing Axe
	[3135]={s=0},  -- Sharp Throwing Axe
	[3137]={s=0},  -- Deadly Throwing Axe
	[3151]={s=87},  -- Siege Brigade Vest
	[3152]={s=28},  -- Driving Gloves
	[3153]={s=33},  -- Oil-stained Cloak
	[3154]={s=1094},  -- Thelsamar Axe
	[3155]={s=0},  -- Remedy of Arugal
	[3156]={s=0},  -- Glutton Shackle
	[3157]={s=0},  -- Darksoul Shackle
	[3158]={s=60},  -- Burnt Hide Bracers
	[3160]={s=470},  -- Ironplate Buckler
	[3161]={s=294},  -- Robe of the Keeper
	[3162]={s=0},  -- Notched Rib
	[3163]={s=0},  -- Blackened Skull
	[3164]={s=33},  -- Discolored Worg Heart
	[3165]={s=0},  -- Quinn's Potion
	[3166]={s=407},  -- Ironheart Chain
	[3167]={s=68},  -- Thick Spider Hair
	[3169]={s=18},  -- Chipped Bear Tooth
	[3170]={s=47},  -- Large Bear Tooth
	[3171]={s=6},  -- Broken Boar Tusk
	[3172]={s=18},  -- Boar Intestines
	[3173]={s=15},  -- Bear Meat
	[3174]={s=16},  -- Spider Ichor
	[3175]={s=100},  -- Ruined Dragonhide
	[3176]={s=75},  -- Small Claw
	[3177]={s=50},  -- Tiny Fang
	[3179]={s=125},  -- Cracked Dragon Molting
	[3180]={s=168},  -- Flecked Raptor Scale
	[3181]={s=23},  -- Partially Digested Meat
	[3182]={s=387},  -- Spider's Silk
	[3183]={s=0},  -- Mangy Claw
	[3184]={s=1394},  -- Hook Dagger
	[3185]={s=8088},  -- Acrobatic Staff
	[3186]={s=4436},  -- Viking Sword
	[3187]={s=14870},  -- Sacrificial Kris
	[3188]={s=879},  -- Coral Claymore
	[3189]={s=99},  -- Wood Chopper
	[3190]={s=99},  -- Beatstick
	[3191]={s=3857},  -- Arced War Axe
	[3192]={s=495},  -- Short Bastard Sword
	[3193]={s=2072},  -- Oak Mallet
	[3194]={s=2495},  -- Black Malice
	[3195]={s=1372},  -- Barbaric Battle Axe
	[3196]={s=1377},  -- Edged Bastard Sword
	[3197]={s=9295},  -- Stonecutter Claymore
	[3198]={s=2741},  -- Battering Hammer
	[3199]={s=2262},  -- Battle Slayer
	[3200]={s=19},  -- Burnt Leather Bracers
	[3201]={s=4496},  -- Barbarian War Axe
	[3202]={s=584},  -- Forest Leather Bracers
	[3203]={s=5436},  -- Dense Triangle Mace
	[3204]={s=751},  -- Deepwood Bracers
	[3205]={s=229},  -- Inscribed Leather Bracers
	[3206]={s=4582},  -- Cavalier Two-hander
	[3207]={s=87},  -- Hunting Bracers
	[3208]={s=25378},  -- Conk Hammer
	[3209]={s=6783},  -- Ancient War Sword
	[3210]={s=5626},  -- Brutal War Axe
	[3211]={s=373},  -- Burnished Bracers
	[3212]={s=929},  -- Lambent Scale Bracers
	[3213]={s=89},  -- Veteran Bracers
	[3214]={s=33},  -- Warrior's Bracers
	[3216]={s=55},  -- Warm Winter Robe
	[3217]={s=134},  -- Foreman Belt
	[3218]={s=0},  -- Pyrewood Shackle
	[3220]={s=40},  -- Blood Sausage
	[3223]={s=306},  -- Frostmane Scepter
	[3224]={s=28},  -- Silver-lined Bracers
	[3225]={s=109},  -- Bloodstained Knife
	[3227]={s=2633},  -- Nightbane Staff
	[3228]={s=1098},  -- Jimmied Handcuffs
	[3229]={s=424},  -- Tarantula Silk Sash
	[3230]={s=768},  -- Black Wolf Bracers
	[3231]={s=1266},  -- Cutthroat Pauldrons
	[3233]={s=212},  -- Gnoll Hide Sack
	[3234]={s=0},  -- Deliah's Ring
	[3235]={s=412},  -- Ring of Scorn
	[3236]={s=0},  -- Rot Hide Ichor
	[3237]={s=0},  -- Sample Ichor
	[3238]={s=0},  -- Johaan's Findings
	[3239]={s=3},  -- Rough Weightstone
	[3240]={s=10},  -- Coarse Weightstone
	[3241]={s=40},  -- Heavy Weightstone
	[3248]={s=0},  -- Translated Letter from The Embalmer
	[3250]={s=0},  -- Bethor's Scroll
	[3251]={s=0},  -- Bethor's Potion
	[3252]={s=0},  -- Deathstalker Report
	[3253]={s=0},  -- Grizzled Bear Heart
	[3254]={s=0},  -- Skittering Blood
	[3255]={s=0},  -- Berard's Journal
	[3256]={s=0},  -- Lake Skulker Moss
	[3257]={s=0},  -- Lake Creeper Moss
	[3258]={s=0},  -- Hardened Tumor
	[3260]={s=6},  -- Scarlet Initiate Robes
	[3261]={s=7},  -- Webbed Cloak
	[3262]={s=10},  -- Putrid Wooden Hammer
	[3263]={s=4},  -- Webbed Pants
	[3264]={s=0},  -- Duskbat Wing
	[3265]={s=0},  -- Scavenger Paw
	[3266]={s=0},  -- Scarlet Armband
	[3267]={s=25},  -- Forsaken Shortsword
	[3268]={s=25},  -- Forsaken Dagger
	[3269]={s=25},  -- Forsaken Maul
	[3270]={s=10},  -- Flax Vest
	[3272]={s=13},  -- Zombie Skin Leggings
	[3273]={s=15},  -- Rugged Mail Vest
	[3274]={s=7},  -- Flax Boots
	[3275]={s=5},  -- Flax Gloves
	[3276]={s=15},  -- Deathguard Buckler
	[3277]={s=30},  -- Executor Staff
	[3279]={s=105},  -- Battle Chain Boots
	[3280]={s=33},  -- Battle Chain Bracers
	[3281]={s=56},  -- Battle Chain Gloves
	[3282]={s=235},  -- Battle Chain Pants
	[3283]={s=295},  -- Battle Chain Tunic
	[3284]={s=88},  -- Tribal Boots
	[3285]={s=36},  -- Tribal Bracers
	[3286]={s=59},  -- Tribal Gloves
	[3287]={s=199},  -- Tribal Pants
	[3288]={s=250},  -- Tribal Vest
	[3289]={s=57},  -- Ancestral Boots
	[3290]={s=48},  -- Ancestral Gloves
	[3291]={s=202},  -- Ancestral Woollies
	[3292]={s=203},  -- Ancestral Tunic
	[3293]={s=11},  -- Deadman Cleaver
	[3294]={s=11},  -- Deadman Club
	[3295]={s=10},  -- Deadman Blade
	[3296]={s=10},  -- Deadman Dagger
	[3297]={s=0},  -- Fel Moss
	[3299]={s=48},  -- Fractured Canine
	[3300]={s=9},  -- Rabbit's Foot
	[3301]={s=102},  -- Sharp Canine
	[3302]={s=319},  -- Brackwater Boots
	[3303]={s=70},  -- Brackwater Bracers
	[3304]={s=106},  -- Brackwater Gauntlets
	[3305]={s=492},  -- Brackwater Leggings
	[3306]={s=653},  -- Brackwater Vest
	[3307]={s=215},  -- Barbaric Cloth Boots
	[3308]={s=144},  -- Barbaric Cloth Gloves
	[3309]={s=333},  -- Barbaric Loincloth
	[3310]={s=442},  -- Barbaric Cloth Vest
	[3311]={s=152},  -- Ceremonial Leather Ankleguards
	[3312]={s=70},  -- Ceremonial Leather Bracers
	[3313]={s=519},  -- Ceremonial Leather Harness
	[3314]={s=171},  -- Ceremonial Leather Gloves
	[3315]={s=454},  -- Ceremonial Leather Loincloth
	[3317]={s=0},  -- A Talking Head
	[3318]={s=0},  -- Alaric's Remains
	[3319]={s=110},  -- Short Sabre
	[3321]={s=41},  -- Gray Fur Booties
	[3322]={s=11},  -- Wispy Cloak
	[3323]={s=15},  -- Ghostly Bracers
	[3324]={s=1119},  -- Ghostly Mantle
	[3325]={s=140},  -- Vile Fin Battle Axe
	[3327]={s=141},  -- Vile Fin Oracle Staff
	[3328]={s=46},  -- Spider Web Robe
	[3329]={s=179},  -- Spiked Wooden Plank
	[3330]={s=281},  -- Dargol's Hauberk
	[3331]={s=101},  -- Melrache's Cape
	[3332]={s=48},  -- Perrine's Boots
	[3334]={s=68},  -- Farmer's Shovel
	[3335]={s=46},  -- Farmer's Broom
	[3336]={s=3986},  -- Flesh Piercer
	[3337]={s=0},  -- Dragonmaw War Banner
	[3339]={s=0},  -- Dwarven Tinder
	[3340]={s=31},  -- Incendicite Ore
	[3341]={s=1621},  -- Gauntlets of Ogre Strength
	[3342]={s=137},  -- Captain Sander's Shirt
	[3343]={s=450},  -- Captain Sander's Booty Bag
	[3344]={s=145},  -- Captain Sander's Sash
	[3345]={s=2720},  -- Silk Wizard Hat
	[3347]={s=0},  -- Bundle of Crocolisk Skins
	[3348]={s=0},  -- Giant Crocolisk Skin
	[3349]={s=0},  -- Sida's Bag
	[3352]={s=1250},  -- Ooze-covered Bag
	[3353]={s=0},  -- Rune-inscribed Pendant
	[3354]={s=0},  -- Dalaran Pendant
	[3355]={s=50},  -- Wild Steelbloom
	[3356]={s=30},  -- Kingsblood
	[3357]={s=75},  -- Liferoot
	[3358]={s=175},  -- Khadgar's Whisker
	[3360]={s=625},  -- Stitches' Femur
	[3363]={s=1},  -- Frayed Belt
	[3365]={s=3},  -- Frayed Bracers
	[3369]={s=25},  -- Grave Moss
	[3370]={s=10},  -- Patchwork Belt
	[3371]={s=1},  -- Empty Vial
	[3372]={s=10},  -- Leaded Vial
	[3373]={s=14},  -- Patchwork Bracers
	[3374]={s=45},  -- Calico Belt
	[3375]={s=30},  -- Calico Bracers
	[3376]={s=86},  -- Canvas Belt
	[3377]={s=99},  -- Canvas Bracers
	[3378]={s=132},  -- Brocade Belt
	[3379]={s=152},  -- Brocade Bracers
	[3380]={s=365},  -- Cross-stitched Belt
	[3381]={s=303},  -- Cross-stitched Bracers
	[3382]={s=10},  -- Weak Troll's Blood Potion
	[3383]={s=100},  -- Elixir of Wisdom
	[3384]={s=20},  -- Minor Magic Resistance Potion
	[3385]={s=30},  -- Lesser Mana Potion
	[3386]={s=35},  -- Elixir of Poison Resistance
	[3387]={s=30},  -- Limited Invulnerability Potion
	[3388]={s=40},  -- Strong Troll's Blood Potion
	[3389]={s=40},  -- Elixir of Defense
	[3390]={s=35},  -- Elixir of Lesser Agility
	[3391]={s=20},  -- Elixir of Ogre's Strength
	[3392]={s=1663},  -- Ringed Helm
	[3393]={s=250},  -- Recipe: Minor Magic Resistance Potion
	[3394]={s=250},  -- Recipe: Elixir of Poison Resistance
	[3395]={s=250},  -- Recipe: Limited Invulnerability Potion
	[3396]={s=250},  -- Recipe: Elixir of Lesser Agility
	[3397]={s=0},  -- Young Crocolisk Skin
	[3399]={s=81},  -- Vulture Talon
	[3400]={s=2761},  -- Lucine Longsword
	[3401]={s=81},  -- Rough Crocolisk Scale
	[3402]={s=602},  -- Soft Patch of Fur
	[3403]={s=321},  -- Ivory Boar Tusk
	[3404]={s=181},  -- Buzzard Wing
	[3405]={s=0},  -- Raven Claw Talisman
	[3406]={s=0},  -- Black Feather Quill
	[3407]={s=0},  -- Sapphire of Sky
	[3408]={s=0},  -- Rune of Nesting
	[3409]={s=0},  -- Nightsaber Fang
	[3411]={s=0},  -- Strigid Owl Feather
	[3412]={s=0},  -- Webwood Spider Silk
	[3413]={s=3229},  -- Doomspike
	[3414]={s=4028},  -- Crested Scepter
	[3415]={s=3598},  -- Staff of the Friar
	[3416]={s=2213},  -- Martyr's Chain
	[3417]={s=4629},  -- Onyx Claymore
	[3418]={s=0},  -- Fel Cone
	[3419]={s=125},  -- Red Rose
	[3420]={s=1250},  -- Black Rose
	[3421]={s=50},  -- Simple Wildflowers
	[3422]={s=500},  -- Beautiful Wildflowers
	[3423]={s=5000},  -- Bouquet of White Roses
	[3424]={s=125000},  -- Bouquet of Black Roses
	[3425]={s=0},  -- Woven Wand
	[3426]={s=1000},  -- Bold Yellow Shirt
	[3427]={s=1500},  -- Stylish Black Shirt
	[3428]={s=100},  -- Common Gray Shirt
	[3429]={s=586},  -- Guardsman Belt
	[3430]={s=11026},  -- Sniper Rifle
	[3431]={s=1335},  -- Bone-studded Leather
	[3434]={s=3},  -- Slumber Sand
	[3435]={s=19},  -- Zombie Skin Bracers
	[3437]={s=23},  -- Clasped Belt
	[3439]={s=30},  -- Zombie Skin Boots
	[3440]={s=640},  -- Bonecracker
	[3442]={s=44},  -- Apprentice Sash
	[3443]={s=138},  -- Ceremonial Tomahawk
	[3444]={s=90},  -- Tiller's Vest
	[3445]={s=226},  -- Ceremonial Knife
	[3446]={s=592},  -- Darkwood Staff
	[3447]={s=34},  -- Cryptwalker Boots
	[3448]={s=6},  -- Senggin Root
	[3449]={s=207},  -- Mystic Shawl
	[3450]={s=443},  -- Faerleia's Shield
	[3451]={s=607},  -- Nightglow Concoction
	[3452]={s=2322},  -- Ceranium Rod
	[3453]={s=46},  -- Quilted Bracers
	[3454]={s=105},  -- Reconnaissance Boots
	[3455]={s=188},  -- Deathstalker Shortsword
	[3456]={s=6375},  -- Dog Whistle
	[3457]={s=444},  -- Stamped Trousers
	[3458]={s=334},  -- Rugged Mail Gloves
	[3460]={s=0},  -- Johaan's Special Drink
	[3461]={s=1005},  -- High Robe of the Adjudicator
	[3462]={s=2283},  -- Talonstrike
	[3463]={s=9},  -- Silver Star
	[3464]={s=8},  -- Feathered Arrow
	[3465]={s=9},  -- Exploding Shot
	[3466]={s=500},  -- Strong Flux
	[3467]={s=0},  -- Dull Iron Key
	[3468]={s=0},  -- Renferrel's Findings
	[3469]={s=49},  -- Copper Chain Boots
	[3470]={s=5},  -- Rough Grinding Stone
	[3471]={s=142},  -- Copper Chain Vest
	[3472]={s=71},  -- Runed Copper Gauntlets
	[3473]={s=299},  -- Runed Copper Pants
	[3474]={s=216},  -- Gemmed Copper Gauntlets
	[3476]={s=0},  -- Gray Bear Tongue
	[3477]={s=0},  -- Creeper Ichor
	[3478]={s=10},  -- Coarse Grinding Stone
	[3480]={s=532},  -- Rough Bronze Shoulders
	[3481]={s=1284},  -- Silvered Bronze Shoulders
	[3482]={s=1317},  -- Silvered Bronze Boots
	[3483]={s=965},  -- Silvered Bronze Gauntlets
	[3484]={s=1767},  -- Green Iron Boots
	[3485]={s=1295},  -- Green Iron Gauntlets
	[3486]={s=100},  -- Heavy Grinding Stone
	[3487]={s=1498},  -- Heavy Copper Broadsword
	[3488]={s=613},  -- Copper Battle Axe
	[3489]={s=937},  -- Thick War Axe
	[3490]={s=2731},  -- Deadly Bronze Poniard
	[3491]={s=2741},  -- Heavy Bronze Mace
	[3492]={s=4552},  -- Mighty Iron Hammer
	[3493]={s=3426},  -- Raptor's End
	[3495]={s=0},  -- Elixir of Suffering
	[3496]={s=0},  -- Mountain Lion Blood
	[3497]={s=0},  -- Elixir of Pain
	[3498]={s=0},  -- Taretha's Necklace
	[3499]={s=0},  -- Burnished Gold Key
	[3502]={s=0},  -- Mudsnout Blossoms
	[3505]={s=0},  -- Alterac Signet Ring
	[3506]={s=0},  -- Mudsnout Composite
	[3508]={s=0},  -- Mudsnout Mixture
	[3509]={s=0},  -- Daggerspine Scale
	[3510]={s=0},  -- Torn Fin Eye
	[3511]={s=267},  -- Cloak of the People's Militia
	[3514]={s=0},  -- Mor'Ladim's Skull
	[3515]={s=0},  -- Ataeric's Staff
	[3516]={s=0},  -- Lescovar's Head
	[3517]={s=0},  -- Keg of Shindigger Stout
	[3518]={s=0},  -- Decrypted Letter
	[3520]={s=0},  -- Tainted Keg
	[3521]={s=0},  -- Cleverly Encrypted Letter
	[3530]={s=28},  -- Wool Bandage
	[3531]={s=57},  -- Heavy Wool Bandage
	[3550]={s=0},  -- Targ's Head
	[3551]={s=0},  -- Muckrake's Head
	[3552]={s=0},  -- Glommus's Head
	[3553]={s=0},  -- Mug'thol's Head
	[3554]={s=0},  -- Crown of Will
	[3555]={s=1032},  -- Robe of Solomon
	[3556]={s=1285},  -- Dread Mage Hat
	[3558]={s=1044},  -- Fen Keeper Robe
	[3559]={s=473},  -- Night Watch Gauntlets
	[3560]={s=2102},  -- Mantle of Honor
	[3561]={s=895},  -- Resilient Poncho
	[3562]={s=823},  -- Belt of Vindication
	[3563]={s=557},  -- Seafarer's Pantaloons
	[3564]={s=0},  -- Shipment of Iron
	[3565]={s=280},  -- Beerstained Gloves
	[3566]={s=2023},  -- Raptorbane Armor
	[3567]={s=922},  -- Dwarven Fishing Pole
	[3569]={s=1262},  -- Vicar's Robe
	[3570]={s=839},  -- Bonegrinding Pestle
	[3571]={s=2118},  -- Trogg Beater
	[3572]={s=972},  -- Daryl's Shortsword
	[3573]={s=212},  -- Hunting Quiver
	[3574]={s=212},  -- Hunting Ammo Sack
	[3575]={s=200},  -- Iron Bar
	[3576]={s=35},  -- Tin Bar
	[3577]={s=600},  -- Gold Bar
	[3578]={s=339},  -- Harvester's Pants
	[3581]={s=1046},  -- Serrated Knife
	[3582]={s=474},  -- Acidproof Cloak
	[3583]={s=57},  -- Weathered Belt
	[3585]={s=953},  -- Camouflaged Tunic
	[3586]={s=1034},  -- Logsplitter
	[3587]={s=2862},  -- Embroidered Belt
	[3588]={s=2873},  -- Embroidered Bracers
	[3589]={s=115},  -- Heavy Weave Belt
	[3590]={s=115},  -- Heavy Weave Bracers
	[3591]={s=419},  -- Padded Belt
	[3592]={s=420},  -- Padded Bracers
	[3593]={s=1095},  -- Russet Belt
	[3594]={s=1099},  -- Russet Bracers
	[3595]={s=4},  -- Tattered Cloth Belt
	[3596]={s=4},  -- Tattered Cloth Bracers
	[3597]={s=216},  -- Thick Cloth Belt
	[3598]={s=217},  -- Thick Cloth Bracers
	[3599]={s=4},  -- Thin Cloth Belt
	[3600]={s=4},  -- Thin Cloth Bracers
	[3601]={s=0},  -- Syndicate Missive
	[3602]={s=29},  -- Knitted Belt
	[3603]={s=29},  -- Knitted Bracers
	[3604]={s=500},  -- Bandolier of the Night Watch
	[3605]={s=500},  -- Quiver of the Night Watch
	[3606]={s=29},  -- Woven Belt
	[3607]={s=29},  -- Woven Bracers
	[3608]={s=500},  -- Plans: Mighty Iron Hammer
	[3609]={s=25},  -- Plans: Copper Chain Vest
	[3610]={s=50},  -- Plans: Gemmed Copper Gauntlets
	[3611]={s=500},  -- Plans: Green Iron Boots
	[3612]={s=500},  -- Plans: Green Iron Gauntlets
	[3613]={s=0},  -- Valdred's Hands
	[3614]={s=0},  -- Yowler's Paw
	[3615]={s=0},  -- Kurzen's Head
	[3616]={s=0},  -- Mind's Eye
	[3617]={s=0},  -- Pendant of Shadow
	[3618]={s=0},  -- Gobbler's Head
	[3619]={s=0},  -- Snellig's Snuffbox
	[3621]={s=0},  -- Ivar's Head
	[3622]={s=0},  -- Essence of Nightlash
	[3623]={s=0},  -- Thule's Head
	[3625]={s=0},  -- Nek'rosh's Head
	[3626]={s=0},  -- Head of Baron Vardus
	[3627]={s=0},  -- Fang of Vagash
	[3628]={s=0},  -- Hand of Dextren Ward
	[3629]={s=0},  -- Mistmantle Family Ring
	[3630]={s=0},  -- Head of Targorr
	[3631]={s=0},  -- Bellygrub's Tusk
	[3632]={s=0},  -- Fangore's Paw
	[3633]={s=0},  -- Head of Gath'Ilzogg
	[3634]={s=0},  -- Head of Grimson
	[3635]={s=0},  -- Maggot Eye's Paw
	[3636]={s=0},  -- Scale of Old Murk-Eye
	[3637]={s=0},  -- Head of VanCleef
	[3638]={s=0},  -- Sarltooth's Talon
	[3639]={s=0},  -- Ear of Balgaras
	[3640]={s=0},  -- Head of Deepfury
	[3641]={s=15},  -- Journeyman's Bracers
	[3642]={s=22},  -- Ancestral Bracers
	[3643]={s=71},  -- Spellbinder Bracers
	[3644]={s=47},  -- Barbaric Cloth Bracers
	[3645]={s=189},  -- Seer's Cuffs
	[3647]={s=433},  -- Bright Bracers
	[3649]={s=115},  -- Tribal Buckler
	[3650]={s=68},  -- Battle Shield
	[3651]={s=435},  -- Veteran Shield
	[3652]={s=364},  -- Hunting Buckler
	[3653]={s=438},  -- Ceremonial Buckler
	[3654]={s=366},  -- Brackwater Shield
	[3655]={s=1022},  -- Burnished Shield
	[3656]={s=2116},  -- Lambent Scale Shield
	[3657]={s=0},  -- Hillsbrad Town Registry
	[3658]={s=0},  -- Recovered Tome
	[3659]={s=0},  -- Worn Leather Book
	[3660]={s=0},  -- Tomes of Alterac
	[3661]={s=9},  -- Handcrafted Staff
	[3662]={s=25},  -- Crocolisk Steak
	[3663]={s=125},  -- Murloc Fin Soup
	[3664]={s=100},  -- Crocolisk Gumbo
	[3665]={s=150},  -- Curiously Tasty Omelet
	[3666]={s=100},  -- Gooey Spider Cake
	[3667]={s=25},  -- Tender Crocolisk Meat
	[3668]={s=0},  -- Assassin's Contract
	[3669]={s=195},  -- Gelatinous Goo
	[3670]={s=70},  -- Large Slimy Bone
	[3671]={s=201},  -- Lifeless Skull
	[3672]={s=0},  -- Head of Nagaz
	[3673]={s=45},  -- Broken Arrow
	[3674]={s=95},  -- Decomposed Boot
	[3676]={s=106},  -- Slimy Ichor
	[3678]={s=100},  -- Recipe: Crocolisk Steak
	[3679]={s=100},  -- Recipe: Blood Sausage
	[3680]={s=400},  -- Recipe: Murloc Fin Soup
	[3681]={s=400},  -- Recipe: Crocolisk Gumbo
	[3682]={s=400},  -- Recipe: Curiously Tasty Omelet
	[3683]={s=400},  -- Recipe: Gooey Spider Cake
	[3684]={s=0},  -- Perenolde Tiara
	[3685]={s=71},  -- Raptor Egg
	[3688]={s=0},  -- Bloodstone Oval
	[3689]={s=0},  -- Bloodstone Marble
	[3690]={s=0},  -- Bloodstone Shard
	[3691]={s=0},  -- Bloodstone Wedge
	[3692]={s=0},  -- Hillsbrad Human Skull
	[3693]={s=0},  -- Humbert's Sword
	[3701]={s=0},  -- Darthalia's Sealed Commendation
	[3702]={s=498},  -- Bear Gall Bladder
	[3703]={s=36},  -- Southshore Stout
	[3704]={s=0},  -- Rusted Iron Key
	[3706]={s=0},  -- Ensorcelled Parchment
	[3708]={s=0},  -- Helcular's Rod
	[3710]={s=0},  -- Rod of Helcular
	[3711]={s=0},  -- Belamoore's Research Journal
	[3712]={s=87},  -- Turtle Meat
	[3713]={s=40},  -- Soothing Spices
	[3714]={s=0},  -- Worn Stone Token
	[3715]={s=0},  -- Bracers of Earth Binding
	[3716]={s=0},  -- Murloc Head
	[3717]={s=0},  -- Sack of Murloc Heads
	[3718]={s=0},  -- Foreboding Plans
	[3719]={s=1027},  -- Hillman's Cloak
	[3720]={s=0},  -- Yeti Fur
	[3721]={s=0},  -- Farren's Report
	[3722]={s=213},  -- Familiar Hide
	[3723]={s=68},  -- Familiar Fang
	[3724]={s=81},  -- Familiar Claw
	[3725]={s=166},  -- Familiar Horn
	[3726]={s=125},  -- Big Bear Steak
	[3727]={s=125},  -- Hot Lion Chops
	[3728]={s=300},  -- Tasty Lion Steak
	[3729]={s=300},  -- Soothing Turtle Bisque
	[3730]={s=45},  -- Big Bear Meat
	[3731]={s=55},  -- Lion Meat
	[3732]={s=801},  -- Hooded Cowl
	[3733]={s=1269},  -- Orcish War Chain
	[3734]={s=400},  -- Recipe: Big Bear Steak
	[3735]={s=450},  -- Recipe: Hot Lion Chops
	[3736]={s=500},  -- Recipe: Tasty Lion Steak
	[3737]={s=550},  -- Recipe: Soothing Turtle Bisque
	[3739]={s=1250},  -- Skull Ring
	[3740]={s=2452},  -- Decapitating Sword
	[3741]={s=922},  -- Stomping Boots
	[3742]={s=2862},  -- Bow of Plunder
	[3743]={s=2451},  -- Sentry Buckler
	[3744]={s=0},  -- Bloodstone Pendant
	[3745]={s=0},  -- Rune of Opening
	[3747]={s=1092},  -- Meditative Sash
	[3748]={s=1304},  -- Feline Mantle
	[3749]={s=1320},  -- High Apothecary Cloak
	[3750]={s=2209},  -- Ribbed Breastplate
	[3751]={s=2661},  -- Mercenary Leggings
	[3752]={s=745},  -- Grunt Vest
	[3753]={s=1635},  -- Shepherd's Girdle
	[3754]={s=1492},  -- Shepherd's Gloves
	[3755]={s=5447},  -- Fish Gutter
	[3758]={s=1817},  -- Crusader Belt
	[3759]={s=1216},  -- Insulated Sage Gloves
	[3760]={s=1500},  -- Band of the Undercity
	[3761]={s=3306},  -- Deadskull Shield
	[3763]={s=6761},  -- Lunar Buckler
	[3764]={s=3181},  -- Mantis Boots
	[3765]={s=4811},  -- Brigand's Pauldrons
	[3766]={s=30},  -- Gryphon Feather Quill
	[3767]={s=23},  -- Fine Parchment
	[3769]={s=13},  -- Broken Wand
	[3770]={s=25},  -- Mutton Chop
	[3771]={s=50},  -- Wild Hog Shank
	[3772]={s=0},  -- Conjured Spring Water
	[3775]={s=13},  -- Crippling Poison
	[3776]={s=175},  -- Crippling Poison II
	[3777]={s=10},  -- Lethargy Root
	[3778]={s=1541},  -- Taut Compound Bow
	[3779]={s=2835},  -- Hefty War Axe
	[3780]={s=1877},  -- Long-barreled Musket
	[3781]={s=3125},  -- Broad Claymore
	[3782]={s=3451},  -- Large War Club
	[3783]={s=3048},  -- Light Scimitar
	[3784]={s=4208},  -- Metal Stave
	[3785]={s=3650},  -- Keen Axe
	[3786]={s=3957},  -- Shiny Dirk
	[3787]={s=4289},  -- Stone Club
	[3792]={s=521},  -- Interlaced Belt
	[3793]={s=648},  -- Interlaced Boots
	[3794]={s=774},  -- Interlaced Bracers
	[3795]={s=981},  -- Interlaced Cloak
	[3796]={s=493},  -- Interlaced Gloves
	[3797]={s=1692},  -- Interlaced Pants
	[3798]={s=902},  -- Interlaced Shoulderpads
	[3799]={s=1460},  -- Interlaced Vest
	[3800]={s=1068},  -- Hardened Leather Belt
	[3801]={s=1031},  -- Hardened Leather Boots
	[3802]={s=627},  -- Hardened Leather Bracers
	[3803]={s=1086},  -- Hardened Cloak
	[3804]={s=765},  -- Hardened Leather Gloves
	[3805]={s=1049},  -- Hardened Leather Pants
	[3806]={s=1271},  -- Hardened Leather Shoulderpads
	[3807]={s=1162},  -- Hardened Leather Tunic
	[3808]={s=770},  -- Double Mail Belt
	[3809]={s=962},  -- Double Mail Boots
	[3810]={s=1145},  -- Double Mail Bracers
	[3811]={s=1064},  -- Double-stitched Cloak
	[3812]={s=971},  -- Double Mail Gloves
	[3813]={s=1772},  -- Double Mail Pants
	[3814]={s=1891},  -- Double Mail Shoulderpads
	[3815]={s=1475},  -- Double Mail Vest
	[3816]={s=2102},  -- Reflective Heater
	[3817]={s=1585},  -- Reinforced Buckler
	[3818]={s=125},  -- Fadeleaf
	[3819]={s=100},  -- Wintersbite
	[3820]={s=100},  -- Stranglekelp
	[3821]={s=150},  -- Goldthorn
	[3822]={s=6481},  -- Runic Darkblade
	[3823]={s=100},  -- Lesser Invisibility Potion
	[3824]={s=150},  -- Shadow Oil
	[3825]={s=110},  -- Elixir of Fortitude
	[3826]={s=105},  -- Mighty Troll's Blood Potion
	[3827]={s=120},  -- Mana Potion
	[3828]={s=150},  -- Elixir of Detect Lesser Invisibility
	[3829]={s=150},  -- Frost Oil
	[3830]={s=500},  -- Recipe: Elixir of Fortitude
	[3831]={s=550},  -- Recipe: Mighty Troll's Blood Potion
	[3832]={s=550},  -- Recipe: Elixir of Detect Lesser Invisibility
	[3833]={s=24},  -- Adept's Cloak
	[3834]={s=32},  -- Sturdy Cloth Trousers
	[3835]={s=1106},  -- Green Iron Bracers
	[3836]={s=3053},  -- Green Iron Helm
	[3837]={s=4405},  -- Golden Scale Coif
	[3838]={s=0},  -- Shadowmaw Claw
	[3839]={s=0},  -- Pristine Tigress Fang
	[3840]={s=2571},  -- Green Iron Shoulders
	[3841]={s=3106},  -- Golden Scale Shoulders
	[3842]={s=2906},  -- Green Iron Leggings
	[3843]={s=3882},  -- Golden Scale Leggings
	[3844]={s=5658},  -- Green Iron Hauberk
	[3845]={s=6558},  -- Golden Scale Cuirass
	[3846]={s=3937},  -- Polished Steel Boots
	[3847]={s=4977},  -- Golden Scale Boots
	[3848]={s=1426},  -- Big Bronze Knife
	[3849]={s=5468},  -- Hardened Iron Shortsword
	[3850]={s=7304},  -- Jade Serpentblade
	[3851]={s=6258},  -- Solid Iron Maul
	[3852]={s=8360},  -- Golden Iron Destroyer
	[3853]={s=10153},  -- Moonsteel Broadsword
	[3854]={s=14120},  -- Frost Tiger Blade
	[3855]={s=11248},  -- Massive Iron Axe
	[3856]={s=14221},  -- Shadow Crescent Axe
	[3857]={s=125},  -- Coal
	[3858]={s=250},  -- Mithril Ore
	[3859]={s=60},  -- Steel Bar
	[3860]={s=400},  -- Mithril Bar
	[3862]={s=0},  -- Aged Gorilla Sinew
	[3863]={s=0},  -- Jungle Stalker Feather
	[3864]={s=800},  -- Citrine
	[3866]={s=1000},  -- Plans: Jade Serpentblade
	[3867]={s=950},  -- Plans: Golden Iron Destroyer
	[3868]={s=1250},  -- Plans: Frost Tiger Blade
	[3869]={s=1250},  -- Plans: Shadow Crescent Axe
	[3870]={s=750},  -- Plans: Green Iron Shoulders
	[3871]={s=850},  -- Plans: Golden Scale Shoulders
	[3872]={s=800},  -- Plans: Golden Scale Leggings
	[3873]={s=1100},  -- Plans: Golden Scale Cuirass
	[3874]={s=1100},  -- Plans: Polished Steel Boots
	[3875]={s=1250},  -- Plans: Golden Scale Boots
	[3876]={s=0},  -- Fang of Bhag'thera
	[3877]={s=0},  -- Talon of Tethis
	[3879]={s=0},  -- Paw of Sin'Dall
	[3880]={s=0},  -- Head of Bangalash
	[3882]={s=13},  -- Buzzard Feather
	[3889]={s=1584},  -- Russet Hat
	[3890]={s=2040},  -- Studded Hat
	[3891]={s=2456},  -- Augmented Chain Helm
	[3892]={s=4388},  -- Embroidered Hat
	[3893]={s=5504},  -- Reinforced Leather Cap
	[3894]={s=5997},  -- Brigandine Helm
	[3897]={s=0},  -- Dizzy's Eye
	[3898]={s=0},  -- Library Scrip
	[3899]={s=25},  -- Legends of the Gurubashi, Volume 3
	[3900]={s=0},  -- Pupellyverbos Port
	[3901]={s=0},  -- Bloodscalp Tusk
	[3902]={s=1317},  -- Staff of Nobles
	[3904]={s=0},  -- Gan'zulah's Head
	[3905]={s=0},  -- Nezzliok's Head
	[3906]={s=0},  -- Balia'mah Trophy
	[3907]={s=0},  -- Ziata'jai Trophy
	[3908]={s=0},  -- Zul'Mamwe Trophy
	[3909]={s=0},  -- Broken Armor of Ana'thek
	[3910]={s=0},  -- Snuff
	[3911]={s=0},  -- Pulsing Blue Shard
	[3912]={s=0},  -- Soul Gem
	[3913]={s=0},  -- Filled Soul Gem
	[3914]={s=6250},  -- Journeyman's Backpack
	[3915]={s=0},  -- Bloody Bone Necklace
	[3916]={s=0},  -- Split Bone Necklace
	[3917]={s=0},  -- Singing Blue Crystal
	[3918]={s=0},  -- Singing Crystal Shard
	[3919]={s=0},  -- Mistvale Giblets
	[3920]={s=0},  -- Bloodsail Charts
	[3921]={s=0},  -- Bloodsail Orders
	[3922]={s=0},  -- Shaky's Payment
	[3923]={s=0},  -- Water Elemental Bracers
	[3924]={s=0},  -- Maury's Clubbed Foot
	[3925]={s=0},  -- Jon-Jon's Golden Spyglass
	[3926]={s=0},  -- Chucky's Huge Ring
	[3927]={s=150},  -- Fine Aged Cheddar
	[3928]={s=250},  -- Superior Healing Potion
	[3930]={s=0},  -- Maury's Key
	[3931]={s=185},  -- Poisoned Spider Fang
	[3932]={s=0},  -- Smotts' Chest
	[3935]={s=0},  -- Smotts' Cutlass
	[3936]={s=985},  -- Crochet Belt
	[3937]={s=2018},  -- Crochet Boots
	[3938]={s=1189},  -- Crochet Bracers
	[3939]={s=2256},  -- Crochet Cloak
	[3940]={s=1630},  -- Crochet Gloves
	[3941]={s=2598},  -- Crochet Pants
	[3942]={s=2636},  -- Crochet Shoulderpads
	[3943]={s=2244},  -- Crochet Vest
	[3944]={s=2277},  -- Twill Belt
	[3945]={s=3852},  -- Twill Boots
	[3946]={s=2431},  -- Twill Bracers
	[3947]={s=3258},  -- Twill Cloak
	[3948]={s=3092},  -- Twill Gloves
	[3949]={s=6517},  -- Twill Pants
	[3950]={s=4157},  -- Twill Shoulderpads
	[3951]={s=5897},  -- Twill Vest
	[3960]={s=0},  -- Bag of Water Elemental Bracers
	[3961]={s=1503},  -- Thick Leather Belt
	[3962]={s=3079},  -- Thick Leather Boots
	[3963]={s=1402},  -- Thick Leather Bracers
	[3964]={s=2127},  -- Thick Cloak
	[3965]={s=2221},  -- Thick Leather Gloves
	[3966]={s=2625},  -- Thick Leather Pants
	[3967]={s=2903},  -- Thick Leather Shoulderpads
	[3968]={s=3331},  -- Thick Leather Tunic
	[3969]={s=3256},  -- Smooth Leather Belt
	[3970]={s=4296},  -- Smooth Leather Boots
	[3971]={s=3811},  -- Smooth Leather Bracers
	[3972]={s=3891},  -- Smooth Cloak
	[3973]={s=3657},  -- Smooth Leather Gloves
	[3974]={s=5486},  -- Smooth Leather Pants
	[3975]={s=3896},  -- Smooth Leather Shoulderpads
	[3976]={s=6978},  -- Smooth Leather Armor
	[3985]={s=0},  -- Monogrammed Sash
	[3986]={s=5332},  -- Protective Pavise
	[3987]={s=6837},  -- Deflecting Tower
	[3989]={s=3154},  -- Blocking Targe
	[3990]={s=8237},  -- Crested Buckler
	[3992]={s=3082},  -- Laminated Scale Belt
	[3993]={s=4940},  -- Laminated Scale Boots
	[3994]={s=4404},  -- Laminated Scale Bracers
	[3995]={s=6284},  -- Laminated Scale Cloak
	[3996]={s=4659},  -- Laminated Scale Gloves
	[3997]={s=7929},  -- Laminated Scale Pants
	[3998]={s=5656},  -- Laminated Scale Shoulderpads
	[3999]={s=7109},  -- Laminated Scale Armor
	[4000]={s=1797},  -- Overlinked Chain Belt
	[4001]={s=3170},  -- Overlinked Chain Boots
	[4002]={s=2463},  -- Overlinked Chain Bracers
	[4003]={s=4090},  -- Overlinked Chain Cloak
	[4004]={s=2357},  -- Overlinked Chain Gloves
	[4005]={s=3477},  -- Overlinked Chain Pants
	[4006]={s=2434},  -- Overlinked Chain Shoulderpads
	[4007]={s=3696},  -- Overlinked Chain Armor
	[4016]={s=0},  -- Zanzil's Mixture
	[4017]={s=6910},  -- Sharp Shortsword
	[4018]={s=6372},  -- Whetted Claymore
	[4019]={s=8336},  -- Heavy Flint Axe
	[4020]={s=11189},  -- Splintering Battle Axe
	[4021]={s=7198},  -- Blunting Mace
	[4022]={s=12059},  -- Crushing Maul
	[4023]={s=6215},  -- Fine Pointed Dagger
	[4024]={s=9821},  -- Heavy War Staff
	[4025]={s=5070},  -- Balanced Long Bow
	[4026]={s=4362},  -- Sentinel Musket
	[4027]={s=0},  -- Catelyn's Blade
	[4028]={s=0},  -- Bundle of Akiris Reeds
	[4029]={s=0},  -- Akiris Reed
	[4034]={s=0},  -- Stone of the Tides
	[4035]={s=1988},  -- Silver-thread Robe
	[4036]={s=681},  -- Silver-thread Cuffs
	[4037]={s=1821},  -- Silver-thread Pants
	[4038]={s=3562},  -- Nightsky Robe
	[4039]={s=2215},  -- Nightsky Cowl
	[4040]={s=1347},  -- Nightsky Gloves
	[4041]={s=3149},  -- Aurora Cowl
	[4042]={s=2107},  -- Aurora Gloves
	[4043]={s=1958},  -- Aurora Bracers
	[4044]={s=4584},  -- Aurora Pants
	[4045]={s=2683},  -- Mistscape Bracers
	[4046]={s=6783},  -- Mistscape Pants
	[4047]={s=3959},  -- Mistscape Boots
	[4048]={s=1767},  -- Emblazoned Hat
	[4049]={s=888},  -- Emblazoned Bracers
	[4050]={s=2374},  -- Emblazoned Leggings
	[4051]={s=1669},  -- Emblazoned Boots
	[4052]={s=2699},  -- Insignia Cap
	[4053]={s=0},  -- Large River Crocolisk Skin
	[4054]={s=3625},  -- Insignia Leggings
	[4055]={s=2481},  -- Insignia Boots
	[4056]={s=0},  -- Cortello's Riddle
	[4057]={s=4032},  -- Insignia Chestguard
	[4058]={s=6056},  -- Glyphed Breastplate
	[4059]={s=2233},  -- Glyphed Bracers
	[4060]={s=5648},  -- Glyphed Leggings
	[4061]={s=3306},  -- Imperial Leather Bracers
	[4062]={s=8359},  -- Imperial Leather Pants
	[4063]={s=3596},  -- Imperial Leather Gloves
	[4064]={s=2987},  -- Emblazoned Buckler
	[4065]={s=5311},  -- Combat Shield
	[4066]={s=4845},  -- Insignia Buckler
	[4067]={s=6381},  -- Glyphed Buckler
	[4068]={s=6918},  -- Chief Brigadier Shield
	[4069]={s=11900},  -- Blackforge Buckler
	[4070]={s=7527},  -- Jouster's Crest
	[4071]={s=2939},  -- Glimmering Mail Breastplate
	[4072]={s=1340},  -- Glimmering Mail Gauntlets
	[4073]={s=2230},  -- Glimmering Mail Greaves
	[4074]={s=4785},  -- Mail Combat Armor
	[4075]={s=1984},  -- Mail Combat Gauntlets
	[4076]={s=3301},  -- Mail Combat Boots
	[4077]={s=3298},  -- Mail Combat Headguard
	[4078]={s=4672},  -- Chief Brigadier Coif
	[4079]={s=6753},  -- Chief Brigadier Leggings
	[4080]={s=7469},  -- Blackforge Cowl
	[4082]={s=11699},  -- Blackforge Breastplate
	[4083]={s=4328},  -- Blackforge Gauntlets
	[4084]={s=10136},  -- Blackforge Leggings
	[4085]={s=0},  -- Krazek's Crock Pot
	[4086]={s=6386},  -- Flash Rifle
	[4087]={s=8722},  -- Trueshot Bow
	[4088]={s=18523},  -- Dreadblade
	[4089]={s=15060},  -- Ricochet Blunderbuss
	[4090]={s=20736},  -- Mug O' Hurt
	[4091]={s=22479},  -- Widowmaker
	[4092]={s=1296},  -- Prismatic Basilisk Scale
	[4093]={s=713},  -- Large Basilisk Tail
	[4094]={s=0},  -- Tablet Shard
	[4096]={s=608},  -- Coarse Gorilla Hair
	[4097]={s=305},  -- Chipped Gorilla Tooth
	[4098]={s=0},  -- Carefully Folded Note
	[4099]={s=1131},  -- Tuft of Gorilla Hair
	[4100]={s=23},  -- Crumpled Note
	[4101]={s=26},  -- Ripped Note
	[4102]={s=33},  -- Torn Note
	[4103]={s=0},  -- Shackle Key
	[4104]={s=0},  -- Snapjaw Crocolisk Skin
	[4105]={s=0},  -- Elder Crocolisk Skin
	[4106]={s=0},  -- Tumbled Crystal
	[4107]={s=2136},  -- Tiger Hunter Gloves
	[4108]={s=5403},  -- Panther Hunter Leggings
	[4109]={s=4393},  -- Excelsior Boots
	[4110]={s=11999},  -- Master Hunter's Bow
	[4111]={s=12042},  -- Master Hunter's Rifle
	[4112]={s=4182},  -- Choker of the High Shaman
	[4113]={s=4853},  -- Medicine Blanket
	[4114]={s=5826},  -- Darktide Cape
	[4115]={s=5783},  -- Grom'gol Buckler
	[4116]={s=12337},  -- Olmann Sewar
	[4117]={s=3119},  -- Scorching Sash
	[4118]={s=7313},  -- Poobah's Nose Ring
	[4119]={s=7271},  -- Raptor Hunter Tunic
	[4120]={s=4192},  -- Robe of Crystal Waters
	[4121]={s=1380},  -- Gemmed Gloves
	[4122]={s=8384},  -- Bookmaker's Scepter
	[4123]={s=3804},  -- Frost Metal Pauldrons
	[4124]={s=3991},  -- Cap of Harmony
	[4125]={s=3142},  -- Tranquil Orb
	[4126]={s=6396},  -- Guerrilla Cleaver
	[4127]={s=8073},  -- Shrapnel Blaster
	[4128]={s=14587},  -- Silver Spade
	[4129]={s=9444},  -- Collection Plate
	[4130]={s=2171},  -- Smotts' Compass
	[4131]={s=3815},  -- Belt of Corruption
	[4132]={s=2681},  -- Darkspear Armsplints
	[4133]={s=1794},  -- Darkspear Cuffs
	[4134]={s=22495},  -- Nimboya's Mystical Staff
	[4135]={s=1130},  -- Bloodbone Band
	[4136]={s=6021},  -- Darkspear Boots
	[4137]={s=4010},  -- Darkspear Shoes
	[4138]={s=10140},  -- Blackwater Tunic
	[4139]={s=2749},  -- Junglewalker Sandals
	[4140]={s=1875},  -- Palm Frond Mantle
	[4197]={s=2765},  -- Berylline Pads
	[4213]={s=2500},  -- Grimoire of Doom
	[4231]={s=110},  -- Cured Light Hide
	[4232]={s=125},  -- Medium Hide
	[4233]={s=200},  -- Cured Medium Hide
	[4234]={s=150},  -- Heavy Leather
	[4235]={s=200},  -- Heavy Hide
	[4236]={s=225},  -- Cured Heavy Hide
	[4237]={s=34},  -- Handstitched Leather Belt
	[4238]={s=200},  -- Linen Bag
	[4239]={s=71},  -- Embossed Leather Gloves
	[4240]={s=300},  -- Woolen Bag
	[4241]={s=450},  -- Green Woolen Bag
	[4242]={s=347},  -- Embossed Leather Pants
	[4243]={s=461},  -- Fine Leather Tunic
	[4244]={s=723},  -- Hillman's Leather Vest
	[4245]={s=2000},  -- Small Silk Pack
	[4246]={s=125},  -- Fine Leather Belt
	[4247]={s=1049},  -- Hillman's Leather Gloves
	[4248]={s=791},  -- Dark Leather Gloves
	[4249]={s=703},  -- Dark Leather Belt
	[4250]={s=705},  -- Hillman's Belt
	[4251]={s=1199},  -- Hillman's Shoulders
	[4252]={s=1457},  -- Dark Leather Shoulders
	[4253]={s=962},  -- Toughened Leather Gloves
	[4254]={s=1071},  -- Barbaric Gloves
	[4255]={s=2366},  -- Green Leather Armor
	[4256]={s=3477},  -- Guardian Armor
	[4257]={s=1311},  -- Green Leather Belt
	[4258]={s=1592},  -- Guardian Belt
	[4259]={s=1934},  -- Green Leather Bracers
	[4260]={s=2559},  -- Guardian Leather Bracers
	[4261]={s=31},  -- Solliden's Trousers
	[4262]={s=2652},  -- Gem-studded Leather Belt
	[4263]={s=94},  -- Standard Issue Shield
	[4264]={s=2804},  -- Barbaric Belt
	[4265]={s=650},  -- Heavy Armor Kit
	[4278]={s=25},  -- Lesser Bloodstone Ore
	[4289]={s=12},  -- Salt
	[4290]={s=715},  -- Dust Bowl
	[4291]={s=125},  -- Silken Thread
	[4292]={s=200},  -- Pattern: Green Woolen Bag
	[4293]={s=162},  -- Pattern: Hillman's Leather Vest
	[4294]={s=400},  -- Pattern: Hillman's Belt
	[4296]={s=525},  -- Pattern: Dark Leather Shoulders
	[4297]={s=500},  -- Pattern: Barbaric Gloves
	[4298]={s=162},  -- Pattern: Guardian Belt
	[4299]={s=500},  -- Pattern: Guardian Armor
	[4300]={s=700},  -- Pattern: Guardian Leather Bracers
	[4301]={s=875},  -- Pattern: Barbaric Belt
	[4302]={s=146},  -- Small Green Dagger
	[4303]={s=398},  -- Cranial Thumper
	[4304]={s=300},  -- Thick Leather
	[4305]={s=600},  -- Bolt of Silk Cloth
	[4306]={s=150},  -- Silk Cloth
	[4307]={s=29},  -- Heavy Linen Gloves
	[4308]={s=45},  -- Green Linen Bracers
	[4309]={s=226},  -- Handstitched Linen Britches
	[4310]={s=180},  -- Heavy Woolen Gloves
	[4311]={s=475},  -- Heavy Woolen Cloak
	[4312]={s=237},  -- Soft-soled Linen Boots
	[4313]={s=416},  -- Red Woolen Boots
	[4314]={s=331},  -- Double-stitched Woolen Shoulders
	[4315]={s=425},  -- Reinforced Woolen Shoulders
	[4316]={s=743},  -- Heavy Woolen Pants
	[4317]={s=1076},  -- Phoenix Pants
	[4318]={s=610},  -- Gloves of Meditation
	[4319]={s=815},  -- Azure Silk Gloves
	[4320]={s=979},  -- Spidersilk Boots
	[4321]={s=1120},  -- Spider Silk Slippers
	[4322]={s=1810},  -- Enchanter's Cowl
	[4323]={s=1999},  -- Shadow Hood
	[4324]={s=1874},  -- Azure Silk Vest
	[4325]={s=2272},  -- Boots of the Enchanter
	[4326]={s=2496},  -- Long Silken Cloak
	[4327]={s=3788},  -- Icy Cloak
	[4328]={s=1524},  -- Spider Belt
	[4329]={s=2120},  -- Star Belt
	[4330]={s=250},  -- Stylish Red Shirt
	[4331]={s=526},  -- Phoenix Gloves
	[4332]={s=500},  -- Bright Yellow Shirt
	[4333]={s=1200},  -- Dark Silk Shirt
	[4334]={s=550},  -- Formal White Shirt
	[4335]={s=1500},  -- Rich Purple Silk Shirt
	[4336]={s=1500},  -- Black Swashbuckler's Shirt
	[4337]={s=750},  -- Thick Spider's Silk
	[4338]={s=250},  -- Mageweave Cloth
	[4339]={s=1250},  -- Bolt of Mageweave
	[4340]={s=87},  -- Gray Dye
	[4341]={s=125},  -- Yellow Dye
	[4342]={s=625},  -- Purple Dye
	[4343]={s=60},  -- Brown Linen Pants
	[4344]={s=11},  -- Brown Linen Shirt
	[4345]={s=100},  -- Pattern: Red Woolen Boots
	[4346]={s=100},  -- Pattern: Heavy Woolen Cloak
	[4347]={s=150},  -- Pattern: Reinforced Woolen Shoulders
	[4348]={s=175},  -- Pattern: Phoenix Gloves
	[4349]={s=175},  -- Pattern: Phoenix Pants
	[4350]={s=200},  -- Pattern: Spider Silk Slippers
	[4351]={s=225},  -- Pattern: Shadow Hood
	[4352]={s=275},  -- Pattern: Boots of the Enchanter
	[4353]={s=300},  -- Pattern: Spider Belt
	[4354]={s=350},  -- Pattern: Rich Purple Silk Shirt
	[4355]={s=375},  -- Pattern: Icy Cloak
	[4356]={s=375},  -- Pattern: Star Belt
	[4357]={s=4},  -- Rough Blasting Powder
	[4358]={s=30},  -- Rough Dynamite
	[4359]={s=12},  -- Handful of Copper Bolts
	[4360]={s=60},  -- Rough Copper Bomb
	[4361]={s=120},  -- Copper Tube
	[4362]={s=187},  -- Rough Boomstick
	[4363]={s=50},  -- Copper Modulator
	[4364]={s=12},  -- Coarse Blasting Powder
	[4365]={s=75},  -- Coarse Dynamite
	[4366]={s=75},  -- Target Dummy
	[4367]={s=150},  -- Small Seaforium Charge
	[4368]={s=408},  -- Flying Tiger Goggles
	[4369]={s=1179},  -- Deadly Blunderbuss
	[4370]={s=175},  -- Large Copper Bomb
	[4371]={s=200},  -- Bronze Tube
	[4372]={s=1800},  -- Lovingly Crafted Boomstick
	[4373]={s=722},  -- Shadow Goggles
	[4374]={s=200},  -- Small Bronze Bomb
	[4375]={s=115},  -- Whirring Bronze Gizmo
	[4376]={s=200},  -- Flame Deflector
	[4377]={s=150},  -- Heavy Blasting Powder
	[4378]={s=350},  -- Heavy Dynamite
	[4379]={s=2357},  -- Silver-plated Shotgun
	[4380]={s=500},  -- Big Bronze Bomb
	[4381]={s=600},  -- Minor Recombobulator
	[4382]={s=600},  -- Bronze Framework
	[4383]={s=3183},  -- Moonsight Rifle
	[4384]={s=1000},  -- Explosive Sheep
	[4385]={s=1410},  -- Green Tinted Goggles
	[4386]={s=175},  -- Ice Deflector
	[4387]={s=400},  -- Iron Strut
	[4388]={s=1000},  -- Discombobulator Ray
	[4389]={s=750},  -- Gyrochronatom
	[4390]={s=500},  -- Iron Grenade
	[4391]={s=4000},  -- Compact Harvest Reaper Kit
	[4392]={s=2500},  -- Advanced Target Dummy
	[4393]={s=2632},  -- Craftsman's Monocle
	[4394]={s=750},  -- Big Iron Bomb
	[4395]={s=1600},  -- Goblin Land Mine
	[4396]={s=6000},  -- Mechanical Dragonling
	[4397]={s=5000},  -- Gnomish Cloaking Device
	[4398]={s=900},  -- Large Seaforium Charge
	[4399]={s=50},  -- Wooden Stock
	[4400]={s=500},  -- Heavy Stock
	[4401]={s=100},  -- Mechanical Squirrel Box
	[4402]={s=250},  -- Small Flame Sac
	[4403]={s=2000},  -- Portable Bronze Mortar
	[4404]={s=25},  -- Silver Contact
	[4405]={s=125},  -- Crude Scope
	[4406]={s=600},  -- Standard Scope
	[4407]={s=1200},  -- Accurate Scope
	[4408]={s=162},  -- Schematic: Mechanical Squirrel
	[4409]={s=200},  -- Schematic: Small Seaforium Charge
	[4410]={s=250},  -- Schematic: Shadow Goggles
	[4411]={s=275},  -- Schematic: Flame Deflector
	[4412]={s=375},  -- Schematic: Moonsight Rifle
	[4413]={s=450},  -- Schematic: Discombobulator Ray
	[4414]={s=462},  -- Schematic: Portable Bronze Mortar
	[4415]={s=550},  -- Schematic: Craftsman's Monocle
	[4416]={s=600},  -- Schematic: Goblin Land Mine
	[4417]={s=675},  -- Schematic: Large Seaforium Charge
	[4419]={s=112},  -- Scroll of Intellect III
	[4421]={s=100},  -- Scroll of Protection III
	[4422]={s=112},  -- Scroll of Stamina III
	[4424]={s=100},  -- Scroll of Spirit III
	[4425]={s=125},  -- Scroll of Agility III
	[4426]={s=125},  -- Scroll of Strength III
	[4428]={s=331},  -- Spider Palp
	[4429]={s=0},  -- Deepfury's Orders
	[4430]={s=4307},  -- Ethereal Talisman
	[4432]={s=0},  -- Sully Balloo's Letter
	[4433]={s=0},  -- Waterlogged Envelope
	[4434]={s=572},  -- Scarecrow Trousers
	[4435]={s=0},  -- Mote of Myzrael
	[4436]={s=331},  -- Jewel-encrusted Sash
	[4437]={s=1855},  -- Channeler's Staff
	[4438]={s=1692},  -- Pugilist Bracers
	[4439]={s=1788},  -- Bruiser Club
	[4440]={s=0},  -- Sigil of Strom
	[4441]={s=0},  -- MacKreel's Moonshine
	[4443]={s=3472},  -- Grim Pauldrons
	[4444]={s=1490},  -- Black Husk Shield
	[4445]={s=2068},  -- Flesh Carver
	[4446]={s=3594},  -- Blackvenom Blade
	[4447]={s=901},  -- Cloak of Night
	[4448]={s=1991},  -- Husk of Naraxis
	[4449]={s=3332},  -- Naraxis' Fang
	[4450]={s=0},  -- Sigil Fragment
	[4453]={s=0},  -- Sigil of Thoradin
	[4454]={s=3800},  -- Talon of Vultros
	[4455]={s=3096},  -- Raptor Hide Harness
	[4456]={s=1553},  -- Raptor Hide Belt
	[4457]={s=300},  -- Barbecued Buzzard Wing
	[4458]={s=0},  -- Sigil of Arathor
	[4459]={s=150},  -- Brittle Dragon Bone
	[4460]={s=175},  -- Ripped Wing Webbing
	[4461]={s=208},  -- Raptor Hide
	[4462]={s=1425},  -- Cloak of Rot
	[4463]={s=953},  -- Beaded Raptor Collar
	[4464]={s=2380},  -- Trouncing Boots
	[4465]={s=1585},  -- Bonefist Gauntlets
	[4466]={s=0},  -- Sigil of Trollbane
	[4467]={s=0},  -- Sigil of Ignaeus
	[4468]={s=0},  -- Sheathed Trol'kalar
	[4469]={s=0},  -- Rod of Order
	[4470]={s=9},  -- Simple Wood
	[4471]={s=33},  -- Flint and Tinder
	[4472]={s=0},  -- Scroll of Myzrael
	[4473]={s=0},  -- Eldritch Shackles
	[4474]={s=4207},  -- Ravenwood Bow
	[4476]={s=2734},  -- Beastwalker Robe
	[4477]={s=4390},  -- Nefarious Buckler
	[4478]={s=10176},  -- Iridescent Scale Leggings
	[4479]={s=178},  -- Burning Charm
	[4480]={s=185},  -- Thundering Charm
	[4481]={s=176},  -- Cresting Charm
	[4482]={s=0},  -- Sealed Folder
	[4483]={s=0},  -- Burning Key
	[4484]={s=0},  -- Cresting Key
	[4485]={s=0},  -- Thundering Key
	[4487]={s=0},  -- Maiden's Folly Charts
	[4488]={s=0},  -- Spirit of Silverpine Charts
	[4489]={s=0},  -- Maiden's Folly Log
	[4490]={s=0},  -- Spirit of Silverpine Log
	[4491]={s=0},  -- Goggles of Gem Hunting
	[4492]={s=0},  -- Elven Gem
	[4493]={s=0},  -- Elven Gems
	[4494]={s=0},  -- Seahorn's Sealed Letter
	[4495]={s=0},  -- Bloodstone Amulet
	[4496]={s=125},  -- Small Brown Pouch
	[4497]={s=5000},  -- Heavy Brown Bag
	[4498]={s=625},  -- Brown Leather Satchel
	[4499]={s=25000},  -- Huge Brown Sack
	[4500]={s=8750},  -- Traveler's Backpack
	[4502]={s=0},  -- Sample Elven Gem
	[4503]={s=0},  -- Witherbark Tusk
	[4504]={s=2222},  -- Dwarven Guard Cloak
	[4505]={s=1974},  -- Swampland Trousers
	[4506]={s=0},  -- Stromgarde Badge
	[4507]={s=8282},  -- Pit Fighter's Shield
	[4508]={s=7793},  -- Blood-tinged Armor
	[4509]={s=2794},  -- Seawolf Gloves
	[4510]={s=0},  -- Befouled Bloodstone Orb
	[4511]={s=11256},  -- Black Water Hammer
	[4512]={s=0},  -- Highland Raptor Eye
	[4513]={s=0},  -- Raptor Heart
	[4514]={s=0},  -- Sara Balloo's Plea
	[4515]={s=0},  -- Marez's Head
	[4516]={s=0},  -- Otto's Head
	[4517]={s=0},  -- Falconcrest's Head
	[4518]={s=0},  -- Torn Scroll Fragment
	[4519]={s=0},  -- Crumpled Scroll Fragment
	[4520]={s=0},  -- Singed Scroll Fragment
	[4521]={s=0},  -- Alterac Granite
	[4522]={s=0},  -- Witherbark Medicine Pouch
	[4525]={s=0},  -- Trelane's Wand of Invocation
	[4526]={s=0},  -- Raptor Talon Amulet
	[4527]={s=0},  -- Azure Agate
	[4528]={s=0},  -- Tor'gan's Orb
	[4529]={s=0},  -- Enchanted Agate
	[4530]={s=0},  -- Trelane's Phylactery
	[4531]={s=0},  -- Trelane's Orb
	[4532]={s=0},  -- Trelane's Ember Agate
	[4533]={s=0},  -- Sealed Letter to Archmage Malin
	[4534]={s=1173},  -- Steel-clasped Bracers
	[4535]={s=882},  -- Ironforge Memorial Ring
	[4536]={s=1},  -- Shiny Red Apple
	[4537]={s=6},  -- Tel'Abim Banana
	[4538]={s=25},  -- Snapvine Watermelon
	[4539]={s=50},  -- Goldenbark Apple
	[4540]={s=1},  -- Tough Hunk of Bread
	[4541]={s=6},  -- Freshly Baked Bread
	[4542]={s=25},  -- Moist Cornbread
	[4543]={s=4098},  -- White Drakeskin Cap
	[4544]={s=50},  -- Mulgore Spice Bread
	[4545]={s=2202},  -- Radiant Silver Bracers
	[4546]={s=533},  -- Call of the Raptor
	[4547]={s=8319},  -- Gnomish Zapper
	[4548]={s=15028},  -- Servomechanic Sledgehammer
	[4549]={s=2092},  -- Seafire Band
	[4550]={s=2092},  -- Coldwater Ring
	[4551]={s=0},  -- Or'Kalar's Head
	[4552]={s=530},  -- Smooth Stone Chip
	[4553]={s=411},  -- Jagged Piece of Stone
	[4554]={s=708},  -- Shiny Polished Stone
	[4555]={s=155},  -- Thick Scaly Tail
	[4556]={s=903},  -- Speckled Shell Fragment
	[4557]={s=225},  -- Fiery Gland
	[4558]={s=1565},  -- Empty Barrel
	[4560]={s=37},  -- Fine Scimitar
	[4561]={s=309},  -- Scalping Tomahawk
	[4562]={s=298},  -- Severing Axe
	[4563]={s=110},  -- Billy Club
	[4564]={s=610},  -- Spiked Club
	[4565]={s=38},  -- Simple Dagger
	[4566]={s=631},  -- Sturdy Quarterstaff
	[4567]={s=1049},  -- Merc Sword
	[4568]={s=1694},  -- Grunt Axe
	[4569]={s=612},  -- Staunch Hammer
	[4570]={s=922},  -- Birchwood Maul
	[4571]={s=979},  -- War Knife
	[4575]={s=1487},  -- Medicine Staff
	[4576]={s=1184},  -- Light Bow
	[4577]={s=356},  -- Compact Shotgun
	[4580]={s=787},  -- Sabertooth Fang
	[4581]={s=862},  -- Patch of Fine Fur
	[4582]={s=745},  -- Soft Bushy Tail
	[4583]={s=812},  -- Thick Furry Mane
	[4584]={s=937},  -- Large Trophy Paw
	[4585]={s=583},  -- Dripping Spider Mandible
	[4586]={s=713},  -- Smooth Raptor Skin
	[4587]={s=807},  -- Tribal Raptor Feathers
	[4588]={s=900},  -- Pristine Raptor Skull
	[4589]={s=530},  -- Long Elegant Feather
	[4590]={s=655},  -- Curved Yellow Bill
	[4591]={s=413},  -- Eagle Eye
	[4592]={s=1},  -- Longjaw Mud Snapper
	[4593]={s=4},  -- Bristle Whisker Catfish
	[4594]={s=6},  -- Rockscale Cod
	[4595]={s=75},  -- Junglevine Wine
	[4596]={s=25},  -- Discolored Healing Potion
	[4597]={s=250},  -- Recipe: Discolored Healing Potion
	[4598]={s=212},  -- Goblin Fishing Pole
	[4599]={s=100},  -- Cured Ham Steak
	[4600]={s=85},  -- Cherry Grog
	[4601]={s=100},  -- Soft Banana Bread
	[4602]={s=100},  -- Moon Harvest Pumpkin
	[4603]={s=4},  -- Raw Spotted Yellowtail
	[4604]={s=1},  -- Forest Mushroom Cap
	[4605]={s=6},  -- Red-speckled Mushroom
	[4606]={s=25},  -- Spongy Morel
	[4607]={s=50},  -- Delicious Cave Mold
	[4608]={s=100},  -- Raw Black Truffle
	[4609]={s=250},  -- Recipe: Barbecued Buzzard Wing
	[4610]={s=0},  -- Carved Stone Urn
	[4611]={s=50},  -- Blue Pearl
	[4612]={s=0},  -- Black Drake's Heart
	[4613]={s=0},  -- Corroded Black Box
	[4614]={s=0},  -- Pendant of Myzrael
	[4615]={s=0},  -- Blacklash's Bindings
	[4616]={s=3},  -- Ryedol's Lucky Pick
	[4621]={s=0},  -- Ambassador Infernus' Bracer
	[4622]={s=0},  -- Sealed Note to Advisor Belgrum
	[4623]={s=375},  -- Lesser Stoneshield Potion
	[4624]={s=550},  -- Recipe: Lesser Stoneshield Potion
	[4625]={s=250},  -- Firebloom
	[4626]={s=0},  -- Small Stone Shard
	[4627]={s=0},  -- Large Stone Slab
	[4628]={s=0},  -- Bracers of Rock Binding
	[4629]={s=0},  -- Supply Crate
	[4630]={s=0},  -- Scrap Metal
	[4631]={s=0},  -- Tablet of Ryun'eh
	[4632]={s=50},  -- Ornate Bronze Lockbox
	[4633]={s=70},  -- Heavy Bronze Lockbox
	[4634]={s=87},  -- Iron Lockbox
	[4635]={s=0},  -- Hammertoe's Amulet
	[4636]={s=110},  -- Strong Iron Lockbox
	[4637]={s=150},  -- Steel Lockbox
	[4638]={s=200},  -- Reinforced Steel Lockbox
	[4639]={s=162},  -- Enchanted Sea Kelp
	[4640]={s=0},  -- Sign of the Earth
	[4641]={s=0},  -- Hand of Dagun
	[4643]={s=2748},  -- Grimsteel Cape
	[4644]={s=0},  -- The Legacy Heart
	[4645]={s=0},  -- Chains of Hematus
	[4646]={s=0},  -- Star of Xil'yeh
	[4647]={s=0},  -- Yagyin's Digest
	[4648]={s=0},  -- Sigil of the Hammer
	[4649]={s=0},  -- Bonegrip's Note
	[4650]={s=0},  -- Bel'dugur's Note
	[4652]={s=10126},  -- Salbac Shield
	[4653]={s=7178},  -- Ironheel Boots
	[4654]={s=0},  -- Mysterious Fossil
	[4655]={s=71},  -- Giant Clam Meat
	[4656]={s=1},  -- Small Pumpkin
	[4658]={s=23},  -- Warrior's Cloak
	[4659]={s=23},  -- Warrior's Girdle
	[4660]={s=324},  -- Walking Boots
	[4661]={s=929},  -- Bright Mantle
	[4662]={s=24},  -- Journeyman's Cloak
	[4663]={s=23},  -- Journeyman's Belt
	[4665]={s=22},  -- Burnt Cloak
	[4666]={s=26},  -- Burnt Leather Belt
	[4668]={s=32},  -- Battle Chain Cloak
	[4669]={s=41},  -- Battle Chain Girdle
	[4671]={s=32},  -- Ancestral Cloak
	[4672]={s=28},  -- Ancestral Belt
	[4674]={s=32},  -- Tribal Cloak
	[4675]={s=35},  -- Tribal Belt
	[4676]={s=278},  -- Skeletal Gauntlets
	[4677]={s=70},  -- Veteran Cloak
	[4678]={s=108},  -- Veteran Girdle
	[4680]={s=91},  -- Brackwater Cloak
	[4681]={s=109},  -- Brackwater Girdle
	[4683]={s=92},  -- Spellbinder Cloak
	[4684]={s=61},  -- Spellbinder Belt
	[4686]={s=67},  -- Barbaric Cloth Cloak
	[4687]={s=67},  -- Barbaric Cloth Belt
	[4689]={s=106},  -- Hunting Cloak
	[4690]={s=71},  -- Hunting Belt
	[4692]={s=68},  -- Ceremonial Cloak
	[4693]={s=86},  -- Ceremonial Leather Belt
	[4694]={s=515},  -- Burnished Pauldrons
	[4695]={s=327},  -- Burnished Cloak
	[4696]={s=5537},  -- Lapidis Tankard of Tidesippe
	[4697]={s=435},  -- Burnished Girdle
	[4698]={s=301},  -- Seer's Mantle
	[4699]={s=221},  -- Seer's Belt
	[4700]={s=379},  -- Inscribed Leather Spaulders
	[4701]={s=252},  -- Inscribed Cloak
	[4702]={s=0},  -- Prospector's Pick
	[4703]={s=0},  -- Broken Tools
	[4705]={s=1449},  -- Lambent Scale Pauldrons
	[4706]={s=687},  -- Lambent Scale Cloak
	[4707]={s=881},  -- Lambent Scale Girdle
	[4708]={s=461},  -- Bright Belt
	[4709]={s=982},  -- Forest Leather Mantle
	[4710]={s=561},  -- Forest Cloak
	[4711]={s=1112},  -- Glimmering Cloak
	[4712]={s=1228},  -- Glimmering Mail Girdle
	[4713]={s=926},  -- Silver-thread Cloak
	[4714]={s=681},  -- Silver-thread Sash
	[4715]={s=1026},  -- Emblazoned Cloak
	[4716]={s=1658},  -- Combat Cloak
	[4717]={s=2014},  -- Mail Combat Belt
	[4718]={s=2223},  -- Nightsky Mantle
	[4719]={s=1676},  -- Nightsky Cloak
	[4720]={s=1234},  -- Nightsky Sash
	[4721]={s=2809},  -- Insignia Mantle
	[4722]={s=2118},  -- Insignia Cloak
	[4723]={s=1703},  -- Humbert's Pants
	[4724]={s=1763},  -- Humbert's Helm
	[4725]={s=4736},  -- Chief Brigadier Pauldrons
	[4726]={s=2340},  -- Chief Brigadier Cloak
	[4727]={s=2791},  -- Chief Brigadier Girdle
	[4729]={s=3036},  -- Aurora Mantle
	[4731]={s=3824},  -- Glyphed Epaulets
	[4732]={s=2632},  -- Glyphed Cloak
	[4733]={s=7957},  -- Blackforge Pauldrons
	[4734]={s=4208},  -- Mistscape Mantle
	[4735]={s=3621},  -- Mistscape Cloak
	[4736]={s=2616},  -- Mistscape Sash
	[4737]={s=5743},  -- Imperial Leather Spaulders
	[4738]={s=3294},  -- Imperial Leather Belt
	[4739]={s=0},  -- Plainstrider Meat
	[4740]={s=0},  -- Plainstrider Feather
	[4741]={s=5438},  -- Stromgarde Cavalry Leggings
	[4742]={s=0},  -- Mountain Cougar Pelt
	[4743]={s=5430},  -- Pulsating Crystalline Shard
	[4744]={s=1986},  -- Arcane Runed Bracers
	[4745]={s=3230},  -- War Rider Bracers
	[4746]={s=4324},  -- Doomsayer's Robe
	[4751]={s=0},  -- Windfury Talon
	[4752]={s=0},  -- Azure Feather
	[4753]={s=0},  -- Bronze Feather
	[4755]={s=0},  -- Water Pitcher
	[4757]={s=4},  -- Cracked Egg Shells
	[4758]={s=0},  -- Prairie Wolf Paw
	[4759]={s=0},  -- Plainstrider Talon
	[4765]={s=575},  -- Enamelled Broadsword
	[4766]={s=481},  -- Feral Blade
	[4767]={s=139},  -- Coppercloth Gloves
	[4768]={s=139},  -- Adept's Gloves
	[4769]={s=0},  -- Trophy Swoop Quill
	[4770]={s=0},  -- Bristleback Belt
	[4771]={s=264},  -- Harvest Cloak
	[4772]={s=70},  -- Warm Cloak
	[4775]={s=28},  -- Cracked Bill
	[4776]={s=41},  -- Ruffled Feather
	[4777]={s=1408},  -- Ironwood Maul
	[4778]={s=1470},  -- Heavy Spiked Mace
	[4779]={s=13},  -- Dull Kodo Tooth
	[4780]={s=56},  -- Kodo Horn Fragment
	[4781]={s=547},  -- Whispering Vest
	[4782]={s=415},  -- Solstice Robe
	[4783]={s=0},  -- Totem of Hawkwind
	[4784]={s=360},  -- Lifeless Stone
	[4785]={s=469},  -- Brimstone Belt
	[4786]={s=278},  -- Wise Man's Belt
	[4787]={s=577},  -- Burning Pitch
	[4788]={s=526},  -- Agile Boots
	[4789]={s=399},  -- Stable Boots
	[4790]={s=831},  -- Inferno Cloak
	[4791]={s=133},  -- Enchanted Water
	[4792]={s=655},  -- Spirit Cloak
	[4793]={s=744},  -- Sylvan Cloak
	[4794]={s=703},  -- Wolf Bracers
	[4795]={s=705},  -- Bear Bracers
	[4796]={s=708},  -- Owl Bracers
	[4797]={s=852},  -- Fiery Cloak
	[4798]={s=1166},  -- Heavy Runed Cloak
	[4799]={s=608},  -- Antiquated Cloak
	[4800]={s=1221},  -- Mighty Chain Pants
	[4801]={s=0},  -- Stalker Claws
	[4802]={s=0},  -- Cougar Claws
	[4803]={s=0},  -- Prairie Alpha Tooth
	[4804]={s=0},  -- Prairie Wolf Heart
	[4805]={s=0},  -- Flatland Cougar Femur
	[4806]={s=0},  -- Plainstrider Scale
	[4807]={s=0},  -- Swoop Gizzard
	[4808]={s=0},  -- Well Stone
	[4809]={s=0},  -- Ambercorn
	[4810]={s=3351},  -- Boulder Pads
	[4813]={s=33},  -- Small Leather Collar
	[4814]={s=6},  -- Discolored Fang
	[4816]={s=1503},  -- Legionnaire's Leggings
	[4817]={s=2462},  -- Blessed Claymore
	[4818]={s=2854},  -- Executioner's Sword
	[4819]={s=0},  -- Fizsprocket's Clipboard
	[4820]={s=1664},  -- Guardian Buckler
	[4821]={s=1308},  -- Bear Buckler
	[4822]={s=1349},  -- Owl's Disk
	[4823]={s=0},  -- Water of the Seers
	[4824]={s=3371},  -- Blurred Axe
	[4825]={s=4094},  -- Callous Axe
	[4826]={s=3087},  -- Marauder Axe
	[4827]={s=749},  -- Wizard's Belt
	[4828]={s=684},  -- Nightwind Belt
	[4829]={s=830},  -- Dreamer's Belt
	[4830]={s=1894},  -- Saber Leggings
	[4831]={s=1571},  -- Stalking Pants
	[4832]={s=2099},  -- Mystic Sarong
	[4833]={s=1731},  -- Glorious Shoulders
	[4834]={s=0},  -- Venture Co. Documents
	[4835]={s=2110},  -- Elite Shoulders
	[4836]={s=2000},  -- Fireproof Orb
	[4837]={s=2000},  -- Strength of Will
	[4838]={s=2000},  -- Orb of Power
	[4840]={s=142},  -- Long Bayonet
	[4841]={s=0},  -- Horn of Arra'chea
	[4843]={s=0},  -- Amethyst Runestone
	[4844]={s=0},  -- Opal Runestone
	[4845]={s=0},  -- Diamond Runestone
	[4846]={s=0},  -- Cog #5
	[4847]={s=0},  -- Lotwil's Shackles of Elemental Binding
	[4848]={s=0},  -- Battleboar Snout
	[4849]={s=0},  -- Battleboar Flank
	[4850]={s=0},  -- Bristleback Attack Plans
	[4851]={s=0},  -- Dirt-stained Map
	[4852]={s=300},  -- Flash Bomb
	[4854]={s=0},  -- Demon Scarred Cloak
	[4859]={s=0},  -- Burning Blade Medallion
	[4860]={s=741},  -- Glistening Frenzy Scale
	[4861]={s=119},  -- Sleek Feathered Tunic
	[4862]={s=0},  -- Scorpid Worker Tail
	[4863]={s=0},  -- Gnomish Tools
	[4864]={s=0},  -- Minshina's Skull
	[4865]={s=5},  -- Ruined Pelt
	[4866]={s=0},  -- Zalazane's Head
	[4867]={s=8},  -- Broken Scorpid Leg
	[4869]={s=0},  -- Fizzle's Claw
	[4870]={s=0},  -- Canvas Scraps
	[4871]={s=0},  -- Searing Collar
	[4872]={s=95},  -- Dry Scorpid Eye
	[4873]={s=15},  -- Dry Hardened Barnacle
	[4874]={s=46},  -- Clean Fishbones
	[4875]={s=13},  -- Slimy Bone
	[4876]={s=78},  -- Bloody Leather Boot
	[4877]={s=10},  -- Stone Arrowhead
	[4878]={s=56},  -- Broken Bloodstained Bow
	[4879]={s=7},  -- Squashed Rabbit Carcass
	[4880]={s=86},  -- Broken Spear
	[4881]={s=0},  -- Aged Envelope
	[4882]={s=0},  -- Benedict's Key
	[4883]={s=0},  -- Admiral Proudmoore's Orders
	[4886]={s=0},  -- Venomtail Poison Sac
	[4887]={s=0},  -- Intact Makrura Eye
	[4888]={s=0},  -- Crawler Mucus
	[4890]={s=0},  -- Taillasher Egg
	[4891]={s=0},  -- Kron's Amulet
	[4892]={s=0},  -- Durotar Tiger Fur
	[4893]={s=0},  -- Savannah Lion Tusk
	[4894]={s=0},  -- Plainstrider Kidney
	[4895]={s=0},  -- Thunder Lizard Horn
	[4896]={s=0},  -- Kodo Liver
	[4897]={s=0},  -- Thunderhawk Saliva Gland
	[4898]={s=0},  -- Lightning Gland
	[4903]={s=0},  -- Eye of Burning Shadow
	[4904]={s=0},  -- Venomtail Antidote
	[4905]={s=0},  -- Sarkoth's Mangled Claw
	[4906]={s=21},  -- Rainwalker Boots
	[4907]={s=13},  -- Woodland Tunic
	[4908]={s=6},  -- Nomadic Bracers
	[4909]={s=368},  -- Kodo Hunter's Leggings
	[4910]={s=7},  -- Painted Chain Gloves
	[4911]={s=15},  -- Thick Bark Buckler
	[4913]={s=7},  -- Painted Chain Belt
	[4914]={s=5},  -- Battleworn Leather Gloves
	[4915]={s=7},  -- Soft Wool Boots
	[4916]={s=9},  -- Soft Wool Vest
	[4917]={s=14},  -- Battleworn Chain Leggings
	[4918]={s=0},  -- Sack of Supplies
	[4919]={s=5},  -- Soft Wool Belt
	[4920]={s=7},  -- Battleworn Cape
	[4921]={s=12},  -- Dust-covered Leggings
	[4922]={s=15},  -- Jagged Chain Vest
	[4923]={s=25},  -- Primitive Hatchet
	[4924]={s=25},  -- Primitive Club
	[4925]={s=25},  -- Primitive Hand Blade
	[4926]={s=0},  -- Chen's Empty Keg
	[4928]={s=20},  -- Sandrunner Wristguards
	[4929]={s=58},  -- Light Scorpid Armor
	[4931]={s=134},  -- Hickory Shortbow
	[4932]={s=179},  -- Harpy Wing Clipper
	[4933]={s=48},  -- Seasoned Fighter's Cloak
	[4935]={s=23},  -- Wide Metal Girdle
	[4936]={s=23},  -- Dirt-trodden Boots
	[4937]={s=71},  -- Charging Buckler
	[4938]={s=236},  -- Blemished Wooden Staff
	[4939]={s=395},  -- Steady Bastard Sword
	[4940]={s=36},  -- Veiled Grips
	[4941]={s=11},  -- Really Sticky Glue
	[4942]={s=89},  -- Tiger Hide Boots
	[4944]={s=72},  -- Handsewn Cloak
	[4945]={s=37},  -- Faintly Glowing Skull
	[4946]={s=67},  -- Lightweight Boots
	[4947]={s=325},  -- Jagged Dagger
	[4948]={s=326},  -- Stinging Mace
	[4949]={s=1706},  -- Orcish Cleaver
	[4951]={s=13},  -- Squealer's Belt
	[4952]={s=63},  -- Stormstout
	[4953]={s=88},  -- Trogg Ale
	[4954]={s=6},  -- Nomadic Belt
	[4957]={s=250},  -- Old Moneybag
	[4958]={s=36},  -- Sun-beaten Cloak
	[4960]={s=12},  -- Flash Pellet
	[4961]={s=183},  -- Dreamwatcher Staff
	[4962]={s=20},  -- Double-layered Gloves
	[4963]={s=30},  -- Thunderhorn Cloak
	[4964]={s=503},  -- Goblin Smasher
	[4967]={s=116},  -- Tribal Warrior's Shield
	[4968]={s=90},  -- Bound Harness
	[4969]={s=42},  -- Fortified Bindings
	[4970]={s=54},  -- Rough-hewn Kodo Leggings
	[4971]={s=383},  -- Skorn's Hammer
	[4972]={s=64},  -- Cliff Runner Boots
	[4973]={s=35},  -- Plains Hunter Wristguards
	[4974]={s=388},  -- Compact Fighting Knife
	[4975]={s=6477},  -- Vigilant Buckler
	[4976]={s=5486},  -- Mistspray Kilt
	[4977]={s=11893},  -- Sword of Hammerfall
	[4978]={s=7976},  -- Ryedol's Hammer
	[4979]={s=2587},  -- Enchanted Stonecloth Bracers
	[4980]={s=2209},  -- Prospector Gloves
	[4982]={s=961},  -- Ripped Prospector Belt
	[4983]={s=16837},  -- Rock Pulverizer
	[4984]={s=5630},  -- Skull of Impending Doom
	[4986]={s=0},  -- Flawed Power Stone
	[4987]={s=15584},  -- Dwarf Captain's Sword
	[4992]={s=0},  -- Recruitment Letter
	[4995]={s=0},  -- Signed Recruitment Letter
	[4998]={s=837},  -- Blood Ring
	[4999]={s=1052},  -- Azora's Will
	[5001]={s=1038},  -- Heart Ring
	[5002]={s=1535},  -- Glowing Green Talisman
	[5003]={s=1713},  -- Crystal Starfire Medallion
	[5006]={s=0},  -- Khazgorm's Journal
	[5007]={s=1632},  -- Band of Thorns
	[5009]={s=1696},  -- Mindbender Loop
	[5011]={s=1912},  -- Welken Ring
	[5012]={s=0},  -- Fungal Spores
	[5016]={s=2955},  -- Artisan's Trousers
	[5017]={s=0},  -- Nitroglycerin
	[5018]={s=0},  -- Wood Pulp
	[5019]={s=0},  -- Sodium Nitrate
	[5020]={s=3},  -- Kolkar Booty Key
	[5021]={s=0},  -- Explosive Stick of Gann
	[5022]={s=0},  -- Barak's Head
	[5023]={s=0},  -- Verog's Head
	[5025]={s=0},  -- Hezrul's Head
	[5026]={s=0},  -- Fire Tar
	[5027]={s=0},  -- Rendered Spores
	[5028]={s=5537},  -- Lord Sakrasis' Scepter
	[5029]={s=5282},  -- Talisman of the Naga Lord
	[5030]={s=0},  -- Centaur Bracers
	[5038]={s=0},  -- Tear of the Moons
	[5040]={s=0},  -- Shadow Hunter Knife
	[5042]={s=12},  -- Red Ribboned Wrapping Paper
	[5043]={s=0},  -- Red Ribboned Gift
	[5044]={s=0},  -- Blue Ribboned Gift
	[5048]={s=12},  -- Blue Ribboned Wrapping Paper
	[5050]={s=0},  -- Ignition Key
	[5051]={s=1},  -- Dig Rat
	[5052]={s=0},  -- Unconscious Dig Rat
	[5054]={s=0},  -- Samophlange
	[5055]={s=0},  -- Intact Raptor Horn
	[5056]={s=0},  -- Root Sample
	[5057]={s=1},  -- Ripe Watermelon
	[5058]={s=0},  -- Silithid Egg
	[5059]={s=0},  -- Digging Claw
	[5060]={s=0},  -- Thieves' Tools
	[5061]={s=0},  -- Stolen Silver
	[5062]={s=0},  -- Raptor Head
	[5063]={s=0},  -- Kreenig Snarlsnout's Tusk
	[5064]={s=0},  -- Witchwing Talon
	[5065]={s=0},  -- Harpy Lieutenant Ring
	[5066]={s=21},  -- Fissure Plant
	[5067]={s=0},  -- Serena's Head
	[5068]={s=0},  -- Dried Seeds
	[5069]={s=293},  -- Fire Wand
	[5071]={s=443},  -- Shadow Wand
	[5072]={s=0},  -- Lok's Skull
	[5073]={s=0},  -- Nak's Skull
	[5074]={s=0},  -- Kuz's Skull
	[5075]={s=25},  -- Blood Shard
	[5076]={s=0},  -- Shipment of Boots
	[5077]={s=0},  -- Telescopic Lens
	[5078]={s=0},  -- Theramore Medal
	[5079]={s=4642},  -- Cold Basilisk Eye
	[5080]={s=0},  -- Gazlowe's Ledger
	[5081]={s=250},  -- Kodo Hide Bag
	[5082]={s=25},  -- Thin Kodo Leather
	[5083]={s=50},  -- Pattern: Kodo Hide Bag
	[5084]={s=0},  -- Baron Longshore's Head
	[5085]={s=0},  -- Bristleback Quilboar Tusk
	[5086]={s=0},  -- Zhevra Hooves
	[5087]={s=0},  -- Plainstrider Beak
	[5088]={s=0},  -- Control Console Operating Manual
	[5089]={s=0},  -- Console Key
	[5092]={s=240},  -- Charred Razormane Wand
	[5093]={s=247},  -- Razormane Backstabber
	[5094]={s=233},  -- Razormane War Shield
	[5095]={s=3},  -- Rainbow Fin Albacore
	[5096]={s=0},  -- Prowler Claws
	[5097]={s=0},  -- Cats Eye Emerald
	[5098]={s=0},  -- Altered Snapjaw Shell
	[5099]={s=0},  -- Hoof of Lakota'mani
	[5100]={s=0},  -- Echeyakee's Hide
	[5101]={s=0},  -- Ishamuhale's Fang
	[5102]={s=0},  -- Owatanka's Tailspike
	[5103]={s=0},  -- Washte Pawne's Feather
	[5104]={s=0},  -- Heart of Isha Awak
	[5107]={s=139},  -- Deckhand's Shirt
	[5109]={s=223},  -- Stonesplinter Rags
	[5110]={s=257},  -- Dalaran Wizard's Robe
	[5111]={s=320},  -- Rathorian's Cape
	[5112]={s=730},  -- Ritual Blade
	[5113]={s=250},  -- Mark of the Syndicate
	[5114]={s=96},  -- Severed Talon
	[5115]={s=101},  -- Broken Wishbone
	[5116]={s=303},  -- Long Tail Feather
	[5117]={s=825},  -- Vibrant Plume
	[5118]={s=71},  -- Large Flat Tooth
	[5119]={s=118},  -- Fine Loose Hair
	[5120]={s=193},  -- Long Tail Hair
	[5121]={s=162},  -- Dirty Kodo Scale
	[5122]={s=287},  -- Thick Kodo Hair
	[5123]={s=117},  -- Steel Arrowhead
	[5124]={s=117},  -- Small Raptor Tooth
	[5125]={s=155},  -- Charged Scale
	[5128]={s=202},  -- Shed Lizard Skin
	[5133]={s=300},  -- Seeping Gizzard
	[5134]={s=92},  -- Small Furry Paw
	[5135]={s=142},  -- Thin Black Claw
	[5136]={s=177},  -- Torn Furry Ear
	[5137]={s=217},  -- Bright Eyeball
	[5138]={s=0},  -- Harvester's Head
	[5140]={s=6},  -- Flash Powder
	[5143]={s=0},  -- Thunder Lizard Blood
	[5164]={s=0},  -- Thunderhawk Wings
	[5165]={s=0},  -- Sunscale Feather
	[5166]={s=0},  -- Webwood Venom Sac
	[5167]={s=0},  -- Webwood Egg
	[5168]={s=0},  -- Timberling Seed
	[5169]={s=0},  -- Timberling Sprout
	[5170]={s=0},  -- Mossy Tumor
	[5173]={s=25},  -- Deathweed
	[5175]={s=0},  -- Earth Totem
	[5176]={s=0},  -- Fire Totem
	[5177]={s=0},  -- Water Totem
	[5178]={s=0},  -- Air Totem
	[5179]={s=0},  -- Moss-twined Heart
	[5180]={s=2777},  -- Necklace of Harmony
	[5181]={s=1778},  -- Vibrant Silk Cape
	[5182]={s=1769},  -- Shiver Blade
	[5183]={s=1575},  -- Pulsating Hydra Heart
	[5184]={s=0},  -- Filled Crystal Phial
	[5185]={s=0},  -- Crystal Phial
	[5186]={s=0},  -- Partially Filled Vessel
	[5187]={s=1081},  -- Rhahk'Zor's Hammer
	[5188]={s=0},  -- Filled Vessel
	[5189]={s=0},  -- Glowing Fruit
	[5190]={s=0},  -- Shimmering Frond
	[5191]={s=2964},  -- Cruel Barb
	[5192]={s=1803},  -- Thief's Blade
	[5193]={s=940},  -- Cape of the Brotherhood
	[5194]={s=3079},  -- Taskmaster Axe
	[5195]={s=364},  -- Gold-flecked Gloves
	[5196]={s=1830},  -- Smite's Reaver
	[5197]={s=1597},  -- Cookie's Tenderizer
	[5198]={s=1660},  -- Cookie's Stirring Rod
	[5199]={s=804},  -- Smelting Pants
	[5200]={s=2323},  -- Impaling Harpoon
	[5201]={s=3161},  -- Emberstone Staff
	[5202]={s=1147},  -- Corsair's Overshirt
	[5203]={s=0},  -- Flatland Prowler Claw
	[5204]={s=0},  -- Bloodfeather Belt
	[5205]={s=31},  -- Sprouted Frond
	[5206]={s=37},  -- Bogling Root
	[5207]={s=1081},  -- Opaque Wand
	[5208]={s=668},  -- Smoldering Wand
	[5209]={s=770},  -- Gloom Wand
	[5210]={s=1161},  -- Burning Wand
	[5211]={s=1166},  -- Dusk Wand
	[5212]={s=672},  -- Blazing Wand
	[5213]={s=5218},  -- Scorching Wand
	[5214]={s=3935},  -- Wand of Eventide
	[5215]={s=8656},  -- Ember Wand
	[5216]={s=11821},  -- Umbral Wand
	[5217]={s=0},  -- Tainted Heart
	[5218]={s=0},  -- Cleansed Timberling Heart
	[5219]={s=0},  -- Inscribed Bark
	[5220]={s=0},  -- Gnarlpine Fang
	[5221]={s=0},  -- Melenas' Head
	[5232]={s=0},  -- Minor Soulstone
	[5233]={s=0},  -- Stone of Relu
	[5234]={s=0},  -- Flagongut's Fossil
	[5236]={s=2878},  -- Combustible Wand
	[5237]={s=18},  -- Mind-numbing Poison
	[5238]={s=7145},  -- Pitchwood Wand
	[5239]={s=7746},  -- Blackbone Wand
	[5240]={s=1244},  -- Torchlight Wand
	[5241]={s=820},  -- Dwarven Flamestick
	[5242]={s=622},  -- Cinder Wand
	[5243]={s=1312},  -- Firebelcher
	[5244]={s=3465},  -- Consecrated Wand
	[5245]={s=5091},  -- Summoner's Wand
	[5246]={s=3489},  -- Excavation Rod
	[5247]={s=7961},  -- Rod of Sorrow
	[5248]={s=6849},  -- Flash Wand
	[5249]={s=8658},  -- Burning Sliver
	[5250]={s=2646},  -- Charred Wand
	[5251]={s=0},  -- Phial of Scrying
	[5252]={s=1175},  -- Wand of Decay
	[5253]={s=7952},  -- Goblin Igniter
	[5254]={s=308},  -- Rugged Spaulders
	[5256]={s=7227},  -- Kovork's Rattle
	[5257]={s=3159},  -- Dark Hooded Cape
	[5263]={s=1},  -- Pocket Lint
	[5266]={s=11157},  -- Eye of Adaegus
	[5267]={s=59851},  -- Scarlet Kris
	[5268]={s=218},  -- Cracked Silithid Shell
	[5269]={s=95},  -- Silithid Ichor
	[5270]={s=0},  -- Death Cap
	[5271]={s=0},  -- Scaber Stalk
	[5272]={s=0},  -- Insane Scribbles
	[5273]={s=0},  -- Mathystra Relic
	[5274]={s=1003},  -- Rose Mantle
	[5275]={s=175},  -- Binding Girdle
	[5279]={s=1436},  -- Harpy Skinner
	[5299]={s=359},  -- Gloves of the Moon
	[5302]={s=929},  -- Cobalt Buckler
	[5306]={s=1710},  -- Wind Rider Staff
	[5309]={s=1038},  -- Privateer Musket
	[5310]={s=555},  -- Sea Dog Britches
	[5311]={s=601},  -- Buckled Boots
	[5312]={s=419},  -- Riveted Gauntlets
	[5313]={s=650},  -- Totemic Clan Ring
	[5314]={s=528},  -- Boar Hunter's Cape
	[5315]={s=213},  -- Timberland Armguards
	[5316]={s=1355},  -- Barkshell Tunic
	[5317]={s=1360},  -- Dry Moss Tunic
	[5318]={s=1789},  -- Zhovur Axe
	[5319]={s=323},  -- Bashing Pauldrons
	[5320]={s=372},  -- Padded Lamellar Boots
	[5321]={s=1484},  -- Elegant Shortsword
	[5322]={s=4016},  -- Demolition Hammer
	[5323]={s=1632},  -- Everglow Lantern
	[5324]={s=776},  -- Engineer's Hammer
	[5325]={s=498},  -- Welding Shield
	[5326]={s=775},  -- Flaring Baton
	[5327]={s=519},  -- Greasy Tinker's Pants
	[5328]={s=205},  -- Cinched Belt
	[5329]={s=15},  -- Cat Figurine
	[5332]={s=15},  -- Glowing Cat Figurine
	[5334]={s=0},  -- 99-Year-Old Port
	[5335]={s=0},  -- A Sack of Coins
	[5336]={s=0},  -- Grell Earring
	[5337]={s=167},  -- Wayfaring Gloves
	[5338]={s=0},  -- Ancient Moonstone Seal
	[5339]={s=0},  -- Serpentbloom
	[5340]={s=919},  -- Cauldron Stirrer
	[5341]={s=368},  -- Spore-covered Tunic
	[5342]={s=88},  -- Raptor Punch
	[5343]={s=462},  -- Barkeeper's Cloak
	[5344]={s=562},  -- Pointed Axe
	[5345]={s=705},  -- Stonewood Hammer
	[5346]={s=425},  -- Orcish Battle Bow
	[5347]={s=3142},  -- Pestilent Wand
	[5348]={s=0},  -- Worn Parchment
	[5349]={s=0},  -- Conjured Muffin
	[5350]={s=0},  -- Conjured Water
	[5351]={s=403},  -- Bounty Hunter's Ring
	[5352]={s=0},  -- Book: The Powers Below
	[5354]={s=0},  -- Letter to Delgren
	[5355]={s=947},  -- Beastmaster's Girdle
	[5356]={s=2594},  -- Branding Rod
	[5357]={s=2221},  -- Ward of the Vale
	[5359]={s=0},  -- Lorgalis Manuscript
	[5360]={s=0},  -- Highborne Relic
	[5361]={s=16},  -- Fishbone Toothpick
	[5362]={s=18},  -- Chew Toy
	[5363]={s=20},  -- Folded Handkerchief
	[5364]={s=27},  -- Dry Salt Lick
	[5366]={s=0},  -- Glowing Soul Gem
	[5367]={s=22},  -- Primitive Rock Tool
	[5368]={s=48},  -- Empty Wallet
	[5369]={s=32},  -- Gnawed Bone
	[5370]={s=37},  -- Bent Spoon
	[5371]={s=48},  -- Piece of Coral
	[5373]={s=72},  -- Lucky Charm
	[5374]={s=87},  -- Small Pocket Watch
	[5375]={s=95},  -- Scratching Stick
	[5376]={s=66},  -- Broken Mirror
	[5377]={s=57},  -- Scallop Shell
	[5379]={s=0},  -- Boot Knife
	[5382]={s=0},  -- Anaya's Pendant
	[5383]={s=0},  -- Athrikus Narassin's Head
	[5385]={s=0},  -- Crawler Leg
	[5386]={s=0},  -- Fine Moonstalker Pelt
	[5387]={s=0},  -- Enchanted Moonstalker Cloak
	[5388]={s=0},  -- Ran Bloodtooth's Skull
	[5389]={s=0},  -- Corrupted Furbolg Totem
	[5390]={s=0},  -- Fandral's Message
	[5391]={s=0},  -- Rare Earth
	[5392]={s=25},  -- Thistlewood Dagger
	[5393]={s=32},  -- Thistlewood Staff
	[5394]={s=6},  -- Archery Training Gloves
	[5395]={s=16},  -- Woodland Shield
	[5396]={s=0},  -- Key to Searing Gorge
	[5397]={s=0},  -- Defias Gunpowder
	[5398]={s=13},  -- Canopy Leggings
	[5399]={s=11},  -- Tracking Boots
	[5404]={s=469},  -- Serpent's Shoulders
	[5405]={s=7},  -- Draped Cloak
	[5411]={s=0},  -- Winterhoof Cleansing Totem
	[5412]={s=0},  -- Thresher Eye
	[5413]={s=0},  -- Moonstalker Fang
	[5414]={s=0},  -- Grizzled Scalp
	[5415]={s=0},  -- Thunderhorn Cleansing Totem
	[5416]={s=0},  -- Wildmane Cleansing Totem
	[5419]={s=13},  -- Feral Bracers
	[5420]={s=227},  -- Banshee Armor
	[5421]={s=650},  -- Fiery Enchantment
	[5422]={s=692},  -- Brambleweed Leggings
	[5423]={s=2084},  -- Boahn's Fang
	[5424]={s=0},  -- Ancient Statuette
	[5425]={s=419},  -- Runescale Girdle
	[5426]={s=1686},  -- Serpent's Kiss
	[5427]={s=147},  -- Crude Pocket Watch
	[5428]={s=322},  -- An Exotic Cookbook
	[5429]={s=137},  -- A Pretty Rock
	[5430]={s=277},  -- Intricate Bauble
	[5431]={s=155},  -- Empty Hip Flask
	[5432]={s=330},  -- Hickory Pipe
	[5433]={s=138},  -- Rag Doll
	[5435]={s=272},  -- Shiny Dinglehopper
	[5437]={s=0},  -- Bathran's Hair
	[5439]={s=25},  -- Small Quiver
	[5440]={s=0},  -- Bottle of Disease
	[5441]={s=250},  -- Small Shot Pouch
	[5442]={s=0},  -- Head of Arugal
	[5443]={s=1067},  -- Gold-plated Buckler
	[5444]={s=548},  -- Miner's Cape
	[5445]={s=0},  -- Ring of Zoram
	[5446]={s=13},  -- Broken Elemental Bracer
	[5447]={s=20},  -- Damaged Elemental Bracer
	[5448]={s=17},  -- Fractured Elemental Bracer
	[5451]={s=22},  -- Crushed Elemental Bracer
	[5455]={s=0},  -- Divined Scroll
	[5456]={s=0},  -- Divining Scroll
	[5457]={s=23},  -- Severed Voodoo Claw
	[5458]={s=27},  -- Dirtwood Belt
	[5459]={s=472},  -- Defender Axe
	[5460]={s=0},  -- Orendil's Cure
	[5461]={s=0},  -- Branch of Cenarius
	[5462]={s=0},  -- Dartol's Rod of Transformation
	[5463]={s=0},  -- Glowing Gem
	[5464]={s=0},  -- Iron Shaft
	[5465]={s=3},  -- Small Spider Leg
	[5466]={s=8},  -- Scorpid Stinger
	[5467]={s=7},  -- Kodo Meat
	[5468]={s=12},  -- Soft Frenzy Flesh
	[5469]={s=9},  -- Strider Meat
	[5470]={s=28},  -- Thunder Lizard Tail
	[5471]={s=30},  -- Stag Meat
	[5472]={s=10},  -- Kaldorei Spider Kabob
	[5473]={s=10},  -- Scorpid Surprise
	[5474]={s=9},  -- Roasted Kodo Meat
	[5475]={s=0},  -- Wooden Key
	[5476]={s=3},  -- Fillet of Frenzy
	[5477]={s=18},  -- Strider Stew
	[5478]={s=70},  -- Dig Rat Stew
	[5479]={s=125},  -- Crispy Lizard Tail
	[5480]={s=95},  -- Lean Venison
	[5481]={s=0},  -- Satyr Horns
	[5482]={s=10},  -- Recipe: Kaldorei Spider Kabob
	[5483]={s=35},  -- Recipe: Scorpid Surprise
	[5484]={s=60},  -- Recipe: Roasted Kodo Meat
	[5485]={s=100},  -- Recipe: Fillet of Frenzy
	[5486]={s=110},  -- Recipe: Strider Stew
	[5487]={s=200},  -- Recipe: Dig Rat Stew
	[5488]={s=100},  -- Recipe: Crispy Lizard Tail
	[5489]={s=300},  -- Recipe: Lean Venison
	[5490]={s=0},  -- Wrathtail Head
	[5493]={s=0},  -- Elune's Tear
	[5494]={s=0},  -- Handful of Stardust
	[5498]={s=200},  -- Small Lustrous Pearl
	[5500]={s=750},  -- Iridescent Pearl
	[5503]={s=16},  -- Clam Meat
	[5504]={s=22},  -- Tangy Clam Meat
	[5505]={s=0},  -- Teronis' Journal
	[5506]={s=71},  -- Beady Eye Stalk
	[5507]={s=600},  -- Ornate Spyglass
	[5508]={s=0},  -- Fallen Moonstone
	[5509]={s=0},  -- Healthstone
	[5510]={s=0},  -- Greater Healthstone
	[5511]={s=0},  -- Lesser Healthstone
	[5512]={s=0},  -- Minor Healthstone
	[5513]={s=0},  -- Mana Jade
	[5514]={s=0},  -- Mana Agate
	[5516]={s=317},  -- Threshadon Fang
	[5519]={s=0},  -- Iron Pommel
	[5520]={s=0},  -- Velinde's Journal
	[5521]={s=0},  -- Velinde's Key
	[5522]={s=0},  -- Spellstone
	[5523]={s=15},  -- Small Barnacled Clam
	[5524]={s=21},  -- Thick-shelled Clam
	[5525]={s=20},  -- Boiled Clams
	[5526]={s=75},  -- Clam Chowder
	[5527]={s=95},  -- Goblin Deviled Clams
	[5528]={s=200},  -- Recipe: Clam Chowder
	[5529]={s=125},  -- Tomb Dust
	[5530]={s=125},  -- Blinding Powder
	[5533]={s=0},  -- Ilkrud Magthrull's Tome
	[5534]={s=0},  -- Parker's Lunch
	[5535]={s=0},  -- Compendium of the Fallen
	[5536]={s=0},  -- Mythology of the Titans
	[5537]={s=0},  -- Sarilus Foulborne's Head
	[5538]={s=0},  -- Vorrel's Wedding Ring
	[5539]={s=0},  -- Letter of Commendation
	[5540]={s=2107},  -- Pearl-handled Dagger
	[5541]={s=3693},  -- Iridescent Hammer
	[5542]={s=370},  -- Pearl-clasped Cloak
	[5543]={s=450},  -- Plans: Iridescent Hammer
	[5544]={s=0},  -- Dal Bloodclaw's Skull
	[5547]={s=0},  -- Reconstructed Rod
	[5565]={s=1250},  -- Infernal Stone
	[5566]={s=105},  -- Broken Antler
	[5567]={s=196},  -- Silver Hook
	[5568]={s=4},  -- Smooth Pebble
	[5569]={s=203},  -- Seaweed
	[5570]={s=0},  -- Deepmoss Egg
	[5571]={s=250},  -- Small Black Pouch
	[5572]={s=250},  -- Small Green Pouch
	[5573]={s=875},  -- Green Leather Bag
	[5574]={s=875},  -- White Leather Bag
	[5575]={s=2500},  -- Large Green Sack
	[5576]={s=2500},  -- Large Brown Sack
	[5578]={s=300},  -- Plans: Silvered Bronze Breastplate
	[5579]={s=32},  -- Militia Warhammer
	[5580]={s=25},  -- Militia Hammer
	[5581]={s=32},  -- Smooth Walking Staff
	[5582]={s=0},  -- Stonetalon Sap
	[5583]={s=0},  -- Fey Dragon Scale
	[5584]={s=0},  -- Twilight Whisker
	[5585]={s=0},  -- Courser Eye
	[5586]={s=26},  -- Thistlewood Blade
	[5587]={s=512},  -- Thornroot Club
	[5588]={s=0},  -- Lydon's Toxin
	[5589]={s=41},  -- Moss-covered Gauntlets
	[5590]={s=35},  -- Cord Bracers
	[5591]={s=67},  -- Rain-spotted Cape
	[5592]={s=54},  -- Shackled Girdle
	[5593]={s=116},  -- Crag Buckler
	[5594]={s=0},  -- Letter to Jin'Zil
	[5595]={s=235},  -- Thicket Hammer
	[5596]={s=141},  -- Ashwood Bow
	[5601]={s=22},  -- Hatched Egg Sac
	[5602]={s=63},  -- Sticky Spider Webbing
	[5604]={s=380},  -- Elven Wand
	[5605]={s=150},  -- Pruning Knife
	[5606]={s=23},  -- Gardening Gloves
	[5608]={s=3463},  -- Living Cowl
	[5609]={s=447},  -- Steadfast Cinch
	[5610]={s=208},  -- Gustweald Cloak
	[5611]={s=452},  -- Tear of Grief
	[5612]={s=72},  -- Ivy Cuffs
	[5613]={s=2635},  -- Staff of the Purifier
	[5614]={s=6147},  -- Seraph's Strike
	[5615]={s=1776},  -- Woodsman Sword
	[5616]={s=22738},  -- Gutwrencher
	[5617]={s=247},  -- Vagabond Leggings
	[5618]={s=86},  -- Scout's Cloak
	[5619]={s=0},  -- Jade Phial
	[5620]={s=0},  -- Vial of Innocent Blood
	[5621]={s=0},  -- Tourmaline Phial
	[5622]={s=556},  -- Clergy Ring
	[5623]={s=0},  -- Amethyst Phial
	[5624]={s=2926},  -- Circlet of the Order
	[5626]={s=1717},  -- Skullchipper
	[5627]={s=1379},  -- Relic Blade
	[5628]={s=0},  -- Zamah's Note
	[5629]={s=347},  -- Hammerfist Gloves
	[5630]={s=348},  -- Windfelt Gloves
	[5631]={s=30},  -- Rage Potion
	[5633]={s=150},  -- Great Rage Potion
	[5634]={s=75},  -- Free Action Potion
	[5635]={s=45},  -- Sharp Claw
	[5636]={s=75},  -- Delicate Feather
	[5637]={s=75},  -- Large Fang
	[5638]={s=0},  -- Toxic Fogger
	[5639]={s=0},  -- Filled Jade Phial
	[5640]={s=25},  -- Recipe: Rage Potion
	[5642]={s=450},  -- Recipe: Free Action Potion
	[5643]={s=500},  -- Recipe: Great Rage Potion
	[5645]={s=0},  -- Filled Tourmaline Phial
	[5646]={s=0},  -- Vial of Blessed Water
	[5655]={s=0},  -- Chestnut Mare Bridle
	[5656]={s=0},  -- Brown Horse Bridle
	[5659]={s=0},  -- Smoldering Embers
	[5664]={s=0},  -- Corroded Shrapnel
	[5665]={s=0},  -- Horn of the Dire Wolf
	[5668]={s=0},  -- Horn of the Brown Wolf
	[5669]={s=0},  -- Dust Devil Debris
	[5675]={s=0},  -- Crystalized Scales
	[5681]={s=0},  -- Corrosive Sap
	[5686]={s=0},  -- Ordanus' Head
	[5687]={s=0},  -- Gatekeeper's Key
	[5689]={s=0},  -- Sleepers' Key
	[5690]={s=0},  -- Claw Key
	[5691]={s=0},  -- Barrow Key
	[5692]={s=0},  -- Remote Detonator (Red)
	[5693]={s=0},  -- Remote Detonator (Blue)
	[5694]={s=0},  -- NG-5 Explosives (Red)
	[5695]={s=0},  -- NG-5 Explosives (Blue)
	[5717]={s=0},  -- Venture Co. Letters
	[5718]={s=0},  -- Venture Co. Engineering Plans
	[5731]={s=0},  -- Scroll of Messaging
	[5732]={s=0},  -- NG-5
	[5733]={s=0},  -- Unidentified Ore
	[5734]={s=0},  -- Super Reaper 6000 Blueprints
	[5735]={s=0},  -- Sealed Envelope
	[5736]={s=0},  -- Gerenzo's Mechanical Arm
	[5737]={s=0},  -- Covert Ops Plans: Alpha & Beta
	[5738]={s=0},  -- Covert Ops Pack
	[5739]={s=2738},  -- Barbaric Harness
	[5740]={s=25},  -- Red Fireworks Rocket
	[5741]={s=111},  -- Rock Chip
	[5744]={s=386},  -- Pale Skinner
	[5749]={s=2664},  -- Scythe Axe
	[5750]={s=641},  -- Warchief's Girdle
	[5751]={s=1028},  -- Webwing Cloak
	[5752]={s=3109},  -- Wyvern Tailspike
	[5753]={s=1884},  -- Ruffled Chaplet
	[5754]={s=2538},  -- Wolfpack Medallion
	[5755]={s=4127},  -- Onyx Shredder Plate
	[5756]={s=10026},  -- Sliverblade
	[5757]={s=1363},  -- Hardwood Cudgel
	[5758]={s=250},  -- Mithril Lockbox
	[5759]={s=375},  -- Thorium Lockbox
	[5760]={s=500},  -- Eternium Lockbox
	[5761]={s=30},  -- Anvilmar Sledge
	[5762]={s=250},  -- Red Linen Bag
	[5763]={s=700},  -- Red Woolen Bag
	[5764]={s=3000},  -- Green Silk Pack
	[5765]={s=4000},  -- Black Silk Pack
	[5766]={s=1338},  -- Lesser Wizard's Robe
	[5767]={s=44},  -- Violet Robes
	[5770]={s=1807},  -- Robes of Arcana
	[5771]={s=50},  -- Pattern: Red Linen Bag
	[5772]={s=125},  -- Pattern: Red Woolen Bag
	[5773]={s=250},  -- Pattern: Robes of Arcana
	[5774]={s=275},  -- Pattern: Green Silk Pack
	[5775]={s=350},  -- Pattern: Black Silk Pack
	[5776]={s=30},  -- Elder's Cane
	[5777]={s=30},  -- Brave's Axe
	[5778]={s=30},  -- Primitive Walking Stick
	[5779]={s=30},  -- Forsaken Bastard Sword
	[5780]={s=156},  -- Murloc Scale Belt
	[5781]={s=601},  -- Murloc Scale Breastplate
	[5782]={s=3211},  -- Thick Murloc Armor
	[5783]={s=2316},  -- Murloc Scale Bracers
	[5784]={s=75},  -- Slimy Murloc Scale
	[5785]={s=500},  -- Thick Murloc Scale
	[5786]={s=137},  -- Pattern: Murloc Scale Belt
	[5787]={s=150},  -- Pattern: Murloc Scale Breastplate
	[5788]={s=162},  -- Pattern: Thick Murloc Armor
	[5789]={s=700},  -- Pattern: Murloc Scale Bracers
	[5790]={s=0},  -- Lonebrow's Journal
	[5791]={s=0},  -- Henrig Lonebrow's Journal
	[5792]={s=0},  -- Razorflank's Medallion
	[5793]={s=0},  -- Razorflank's Heart
	[5794]={s=0},  -- Salty Scorpid Venom
	[5795]={s=0},  -- Hardened Tortoise Shell
	[5796]={s=0},  -- Encrusted Tail Fin
	[5797]={s=0},  -- Indurium Flake
	[5798]={s=0},  -- Rocket Car Parts
	[5799]={s=0},  -- Kravel's Parts Order
	[5800]={s=0},  -- Kravel's Parts
	[5801]={s=0},  -- Kraul Guano
	[5802]={s=0},  -- Delicate Car Parts
	[5803]={s=0},  -- Speck of Dream Dust
	[5804]={s=0},  -- Goblin Rumors
	[5805]={s=0},  -- Heart of Zeal
	[5806]={s=0},  -- Fool's Stout
	[5807]={s=0},  -- Fool's Stout Report
	[5808]={s=0},  -- Pridewing Venom Sac
	[5809]={s=0},  -- Highperch Venom Sac
	[5810]={s=0},  -- Fresh Carcass
	[5811]={s=0},  -- Frostmaw's Mane
	[5812]={s=1129},  -- Robes of Antiquity
	[5813]={s=7087},  -- Emil's Brand
	[5814]={s=2351},  -- Snapbrook Armor
	[5815]={s=5871},  -- Glacial Stone
	[5816]={s=405},  -- Light of Elune
	[5817]={s=3226},  -- Lunaris Bow
	[5818]={s=3239},  -- Moonbeam Wand
	[5819]={s=3201},  -- Sunblaze Coif
	[5820]={s=1622},  -- Faerie Mantle
	[5824]={s=0},  -- Tablet of Will
	[5825]={s=0},  -- Treshala's Pendant
	[5826]={s=0},  -- Kravel's Scheme
	[5827]={s=0},  -- Fizzle Brassbolts' Letter
	[5829]={s=804},  -- Razor-sharp Beak
	[5830]={s=0},  -- Kenata's Head
	[5831]={s=0},  -- Fardel's Head
	[5832]={s=0},  -- Marcel's Head
	[5833]={s=0},  -- Indurium Ore
	[5834]={s=0},  -- Mok'Morokk's Snuff
	[5835]={s=0},  -- Mok'Morokk's Grog
	[5836]={s=0},  -- Mok'Morokk's Strongbox
	[5837]={s=0},  -- Steelsnap's Rib
	[5838]={s=0},  -- Kodo Skin Scroll
	[5839]={s=1},  -- Journal Page
	[5840]={s=0},  -- Searing Tongue
	[5841]={s=0},  -- Searing Heart
	[5842]={s=0},  -- Unrefined Ore Sample
	[5843]={s=0},  -- Grenka's Claw
	[5844]={s=0},  -- Fragments of Rok'Alim
	[5846]={s=0},  -- Korran's Sealed Note
	[5847]={s=0},  -- Mirefin Head
	[5848]={s=0},  -- Hollow Vulture Bone
	[5849]={s=0},  -- Crate of Crash Helmets
	[5850]={s=0},  -- Belgrom's Sealed Note
	[5851]={s=0},  -- Cozzle's Key
	[5852]={s=0},  -- Fuel Regulator Blueprints
	[5853]={s=0},  -- Intact Silithid Carapace
	[5854]={s=0},  -- Silithid Talon
	[5855]={s=0},  -- Silithid Heart
	[5860]={s=0},  -- Legacy of the Aspects
	[5861]={s=0},  -- Beginnings of the Undead Threat
	[5862]={s=0},  -- Seaforium Booster
	[5863]={s=0},  -- Guild Charter
	[5864]={s=0},  -- Gray Ram
	[5865]={s=0},  -- Modified Seaforium Booster
	[5866]={s=0},  -- Sample of Indurium Ore
	[5867]={s=0},  -- Etched Phial
	[5868]={s=0},  -- Filled Etched Phial
	[5869]={s=0},  -- Cloven Hoof
	[5871]={s=318},  -- Large Hoof
	[5872]={s=0},  -- Brown Ram
	[5873]={s=0},  -- White Ram
	[5876]={s=0},  -- Blueleaf Tuber
	[5877]={s=0},  -- Cracked Silithid Carapace
	[5879]={s=0},  -- Twilight Pendant
	[5880]={s=0},  -- Crate With Holes
	[5881]={s=0},  -- Head of Kelris
	[5882]={s=0},  -- Captain's Documents
	[5883]={s=0},  -- Forked Mudrock Tongue
	[5884]={s=0},  -- Unpopped Darkmist Eye
	[5897]={s=0},  -- Snufflenose Owner's Manual
	[5917]={s=0},  -- Spy's Report
	[5918]={s=0},  -- Defiant Orc Head
	[5919]={s=0},  -- Blackened Iron Shield
	[5936]={s=19},  -- Animal Skin Belt
	[5938]={s=0},  -- Pristine Crawler Leg
	[5939]={s=20},  -- Sewing Gloves
	[5940]={s=153},  -- Bone Buckler
	[5941]={s=115},  -- Brass Scale Pants
	[5942]={s=0},  -- Jeweled Pendant
	[5943]={s=840},  -- Rift Bracers
	[5944]={s=331},  -- Greaves of the People's Militia
	[5945]={s=0},  -- Deadmire's Tooth
	[5946]={s=0},  -- Sealed Note to Elling
	[5947]={s=0},  -- Defias Docket
	[5948]={s=0},  -- Letter to Jorgen
	[5950]={s=0},  -- Reethe's Badge
	[5951]={s=41},  -- Moist Towelette
	[5952]={s=0},  -- Corrupted Brain Stem
	[5956]={s=16},  -- Blacksmith's Hammer
	[5957]={s=40},  -- Handstitched Leather Vest
	[5958]={s=829},  -- Fine Leather Pants
	[5959]={s=0},  -- Acidic Venom Sac
	[5960]={s=0},  -- Sealed Note to Watcher Backus
	[5961]={s=1089},  -- Dark Leather Pants
	[5962]={s=2794},  -- Guardian Pants
	[5963]={s=3151},  -- Barbaric Leggings
	[5964]={s=2609},  -- Barbaric Shoulders
	[5965]={s=2536},  -- Guardian Cloak
	[5966]={s=1374},  -- Guardian Gloves
	[5967]={s=209},  -- Girdle of Nobility
	[5969]={s=781},  -- Regent's Cloak
	[5970]={s=418},  -- Serpent Gloves
	[5971]={s=1136},  -- Feathered Cape
	[5972]={s=375},  -- Pattern: Fine Leather Pants
	[5973]={s=162},  -- Pattern: Barbaric Leggings
	[5974]={s=350},  -- Pattern: Guardian Cloak
	[5975]={s=532},  -- Ruffian Belt
	[5976]={s=2500},  -- Guild Tabard
	[5996]={s=95},  -- Elixir of Water Breathing
	[5997]={s=5},  -- Elixir of Minor Defense
	[5998]={s=0},  -- Stormpike's Request
	[6016]={s=0},  -- Wolf Heart Sample
	[6037]={s=1250},  -- Truesilver Bar
	[6038]={s=312},  -- Giant Clam Scorcho
	[6039]={s=1250},  -- Recipe: Giant Clam Scorcho
	[6040]={s=1649},  -- Golden Scale Bracers
	[6041]={s=1500},  -- Steel Weapon Chain
	[6042]={s=250},  -- Iron Shield Spike
	[6043]={s=500},  -- Iron Counterweight
	[6044]={s=450},  -- Plans: Iron Shield Spike
	[6045]={s=650},  -- Plans: Iron Counterweight
	[6046]={s=950},  -- Plans: Steel Weapon Chain
	[6047]={s=1100},  -- Plans: Golden Scale Coif
	[6048]={s=100},  -- Shadow Protection Potion
	[6049]={s=170},  -- Fire Protection Potion
	[6050]={s=300},  -- Frost Protection Potion
	[6051]={s=62},  -- Holy Protection Potion
	[6052]={s=300},  -- Nature Protection Potion
	[6053]={s=200},  -- Recipe: Holy Protection Potion
	[6054]={s=225},  -- Recipe: Shadow Protection Potion
	[6055]={s=375},  -- Recipe: Fire Protection Potion
	[6056]={s=500},  -- Recipe: Frost Protection Potion
	[6057]={s=500},  -- Recipe: Nature Protection Potion
	[6058]={s=6},  -- Blackened Leather Belt
	[6059]={s=13},  -- Nomadic Vest
	[6060]={s=4},  -- Flax Bracers
	[6061]={s=23},  -- Graystone Bracers
	[6062]={s=28},  -- Heavy Cord Bracers
	[6063]={s=23},  -- Cold Steel Gauntlets
	[6064]={s=0},  -- Miniature Platinum Discs
	[6065]={s=0},  -- Khadgar's Essays on Dimensional Convergence
	[6066]={s=0},  -- Khan Dez'hepah's Head
	[6067]={s=0},  -- Centaur Ear
	[6068]={s=375},  -- Recipe: Shadow Oil
	[6069]={s=0},  -- Crudely Dried Meat
	[6070]={s=6},  -- Wolfskin Bracers
	[6071]={s=0},  -- Draenethyst Crystal
	[6072]={s=0},  -- Khan Jehn's Head
	[6073]={s=0},  -- Khan Shaka's Head
	[6074]={s=0},  -- War Horn Mouthpiece
	[6076]={s=9},  -- Tapered Pants
	[6077]={s=0},  -- Maraudine Key Fragment
	[6078]={s=15},  -- Pikeman Shield
	[6079]={s=0},  -- Crude Charm
	[6080]={s=0},  -- Shadow Panther Heart
	[6081]={s=0},  -- Mire Lord Fungus
	[6082]={s=0},  -- Deepstrider Tumor
	[6083]={s=0},  -- Broken Tears
	[6084]={s=290},  -- Stormwind Guard Leggings
	[6085]={s=243},  -- Footman Tunic
	[6087]={s=1727},  -- Chausses of Westfall
	[6091]={s=0},  -- Crate of Power Stones
	[6092]={s=420},  -- Black Whelp Boots
	[6093]={s=4418},  -- Orc Crusher
	[6094]={s=1278},  -- Piercing Axe
	[6095]={s=688},  -- Wandering Boots
	[6096]={s=1},  -- Apprentice's Shirt
	[6097]={s=1},  -- Acolyte's Shirt
	[6098]={s=1},  -- Neophyte's Robe
	[6117]={s=1},  -- Squire's Shirt
	[6118]={s=1},  -- Squire's Pants
	[6119]={s=1},  -- Neophyte's Robe
	[6120]={s=1},  -- Recruit's Shirt
	[6121]={s=1},  -- Recruit's Pants
	[6122]={s=1},  -- Recruit's Boots
	[6123]={s=1},  -- Novice's Robe
	[6124]={s=1},  -- Novice's Pants
	[6125]={s=1},  -- Brawler's Harness
	[6126]={s=1},  -- Trapper's Pants
	[6127]={s=1},  -- Trapper's Boots
	[6129]={s=1},  -- Acolyte's Robe
	[6134]={s=1},  -- Primitive Mantle
	[6135]={s=1},  -- Primitive Kilt
	[6136]={s=1},  -- Thug Shirt
	[6137]={s=1},  -- Thug Pants
	[6138]={s=1},  -- Thug Boots
	[6139]={s=1},  -- Novice's Robe
	[6140]={s=1},  -- Apprentice's Robe
	[6144]={s=1},  -- Neophyte's Robe
	[6145]={s=0},  -- Clarice's Pendant
	[6146]={s=0},  -- Sundried Driftwood
	[6147]={s=37},  -- Ratty Old Belt
	[6148]={s=44},  -- Web-covered Boots
	[6149]={s=120},  -- Greater Mana Potion
	[6150]={s=22},  -- A Frayed Knot
	[6166]={s=0},  -- Coyote Jawbone
	[6167]={s=0},  -- Neeka's Report
	[6168]={s=0},  -- Sawtooth Snapper Claw
	[6169]={s=0},  -- Unprepared Sawtooth Flank
	[6170]={s=0},  -- Wizards' Reagents
	[6171]={s=6},  -- Wolf Handler Gloves
	[6172]={s=0},  -- Lost Supplies
	[6173]={s=7},  -- Snow Boots
	[6175]={s=0},  -- Atal'ai Artifact
	[6176]={s=15},  -- Dwarven Kite Shield
	[6177]={s=69},  -- Ironwrought Bracers
	[6178]={s=0},  -- Shipment to Nethergarde
	[6179]={s=556},  -- Privateer's Cape
	[6180]={s=423},  -- Slarkskin
	[6181]={s=0},  -- Fetish of Hakkar
	[6184]={s=0},  -- Monstrous Crawler Leg
	[6185]={s=9},  -- Bear Shawl
	[6186]={s=1372},  -- Trogg Slicer
	[6187]={s=613},  -- Dwarven Defender
	[6188]={s=305},  -- Mud Stompers
	[6189]={s=624},  -- Durable Chain Shoulders
	[6190]={s=0},  -- Draenethyst Shard
	[6191]={s=615},  -- Kimbra Boots
	[6193]={s=0},  -- Bundle of Atal'ai Artifacts
	[6194]={s=5308},  -- Barreling Reaper
	[6195]={s=416},  -- Wax-polished Armor
	[6196]={s=0},  -- Noboru's Cudgel
	[6197]={s=929},  -- Loch Croc Hide Vest
	[6198]={s=1113},  -- Jurassic Wristguards
	[6199]={s=650},  -- Black Widow Band
	[6200]={s=1223},  -- Garneg's War Belt
	[6201]={s=54},  -- Lithe Boots
	[6202]={s=35},  -- Fingerless Gloves
	[6203]={s=121},  -- Thuggish Shield
	[6204]={s=2065},  -- Tribal Worg Helm
	[6205]={s=922},  -- Burrowing Shovel
	[6206]={s=555},  -- Rock Chipper
	[6211]={s=450},  -- Recipe: Elixir of Ogre's Strength
	[6212]={s=0},  -- Head of Jammal'an
	[6214]={s=595},  -- Heavy Copper Maul
	[6215]={s=601},  -- Balanced Fighting Stick
	[6217]={s=24},  -- Copper Rod
	[6218]={s=24},  -- Runed Copper Rod
	[6219]={s=144},  -- Arclight Spanner
	[6220]={s=4893},  -- Meteor Shard
	[6223]={s=4797},  -- Crest of Darkshire
	[6226]={s=890},  -- Bloody Apron
	[6238]={s=98},  -- Brown Linen Robe
	[6239]={s=160},  -- Red Linen Vest
	[6240]={s=161},  -- Blue Linen Vest
	[6241]={s=99},  -- White Linen Robe
	[6242]={s=243},  -- Blue Linen Robe
	[6245]={s=0},  -- Karnitol's Satchel
	[6246]={s=0},  -- Hatefury Claw
	[6247]={s=0},  -- Hatefury Horn
	[6248]={s=0},  -- Scorpashi Venom
	[6249]={s=0},  -- Aged Kodo Hide
	[6250]={s=0},  -- Felhound Brain
	[6251]={s=0},  -- Nether Wing
	[6252]={s=0},  -- Doomwarder Blood
	[6253]={s=0},  -- Leftwitch's Package
	[6256]={s=4},  -- Fishing Pole
	[6257]={s=0},  -- Roc Gizzard
	[6258]={s=0},  -- Ironfur Liver
	[6259]={s=0},  -- Groddoc Liver
	[6260]={s=12},  -- Blue Dye
	[6261]={s=250},  -- Orange Dye
	[6263]={s=589},  -- Blue Overalls
	[6264]={s=884},  -- Greater Adept's Robe
	[6265]={s=0},  -- Soul Shard
	[6266]={s=205},  -- Disciple's Vest
	[6267]={s=149},  -- Disciple's Pants
	[6268]={s=234},  -- Pioneer Tunic
	[6269]={s=193},  -- Pioneer Trousers
	[6270]={s=50},  -- Pattern: Blue Linen Vest
	[6271]={s=50},  -- Pattern: Red Linen Vest
	[6272]={s=75},  -- Pattern: Blue Linen Robe
	[6274]={s=100},  -- Pattern: Blue Overalls
	[6275]={s=200},  -- Pattern: Greater Adept's Robe
	[6281]={s=0},  -- Rattlecage Skull
	[6282]={s=2243},  -- Sacred Burial Trousers
	[6283]={s=0},  -- The Book of Ur
	[6284]={s=0},  -- Runes of Summoning
	[6285]={s=0},  -- Egalin's Grimoire
	[6286]={s=0},  -- Pure Hearts
	[6287]={s=0},  -- Atal'ai Tablet Fragment
	[6288]={s=0},  -- Atal'ai Tablet
	[6289]={s=1},  -- Raw Longjaw Mud Snapper
	[6290]={s=1},  -- Brilliant Smallfish
	[6291]={s=1},  -- Raw Brilliant Smallfish
	[6292]={s=8},  -- 10 Pound Mud Snapper
	[6293]={s=33},  -- Dried Bat Blood
	[6294]={s=10},  -- 12 Pound Mud Snapper
	[6295]={s=12},  -- 15 Pound Mud Snapper
	[6296]={s=28},  -- Patch of Bat Hair
	[6297]={s=7},  -- Old Skull
	[6298]={s=130},  -- Bloody Bat Fang
	[6299]={s=1},  -- Sickly Looking Fish
	[6300]={s=443},  -- Husk Fragment
	[6301]={s=20},  -- Old Teamster's Skull
	[6302]={s=628},  -- Delicate Insect Wing
	[6303]={s=1},  -- Raw Slitherskin Mackerel
	[6304]={s=25},  -- Damp Diary Page (Day 4)
	[6305]={s=25},  -- Damp Diary Page (Day 87)
	[6306]={s=25},  -- Damp Diary Page (Day 512)
	[6307]={s=1},  -- Message in a Bottle
	[6308]={s=2},  -- Raw Bristle Whisker Catfish
	[6309]={s=100},  -- 17 Pound Catfish
	[6310]={s=150},  -- 19 Pound Catfish
	[6311]={s=187},  -- 22 Pound Catfish
	[6312]={s=0},  -- Dalin's Heart
	[6313]={s=0},  -- Comar's Heart
	[6314]={s=1268},  -- Wolfmaster Cape
	[6315]={s=2546},  -- Steelarrow Crossbow
	[6316]={s=3},  -- Loch Frenzy Delight
	[6317]={s=2},  -- Raw Loch Frenzy
	[6318]={s=4802},  -- Odo's Ley Staff
	[6319]={s=803},  -- Girdle of the Blindwatcher
	[6320]={s=2711},  -- Commander's Crest
	[6321]={s=1650},  -- Silverlaine's Family Seal
	[6323]={s=2611},  -- Baron's Scepter
	[6324]={s=1892},  -- Robes of Arugal
	[6325]={s=10},  -- Recipe: Brilliant Smallfish
	[6326]={s=10},  -- Recipe: Slitherskin Mackerel
	[6327]={s=12823},  -- The Pacifier
	[6328]={s=100},  -- Recipe: Longjaw Mud Snapper
	[6329]={s=100},  -- Recipe: Loch Frenzy Delight
	[6330]={s=300},  -- Recipe: Bristle Whisker Catfish
	[6331]={s=9466},  -- Howling Blade
	[6332]={s=1153},  -- Black Pearl Ring
	[6333]={s=1929},  -- Spikelash Dagger
	[6335]={s=1581},  -- Grizzled Boots
	[6336]={s=305},  -- Infantry Tunic
	[6337]={s=245},  -- Infantry Leggings
	[6338]={s=125},  -- Silver Rod
	[6339]={s=24},  -- Runed Silver Rod
	[6340]={s=875},  -- Fenrus' Hide
	[6341]={s=666},  -- Eerie Stable Lantern
	[6342]={s=75},  -- Formula: Enchant Chest - Minor Mana
	[6344]={s=100},  -- Formula: Enchant Bracer - Minor Spirit
	[6346]={s=100},  -- Formula: Enchant Chest - Lesser Mana
	[6347]={s=100},  -- Formula: Enchant Bracer - Minor Strength
	[6348]={s=125},  -- Formula: Enchant Weapon - Minor Beastslayer
	[6349]={s=125},  -- Formula: Enchant 2H Weapon - Lesser Intellect
	[6350]={s=295},  -- Rough Bronze Boots
	[6351]={s=1},  -- Dented Crate
	[6352]={s=1},  -- Waterlogged Crate
	[6353]={s=1},  -- Small Chest
	[6354]={s=1},  -- Small Locked Chest
	[6355]={s=1},  -- Sturdy Locked Chest
	[6356]={s=1},  -- Battered Chest
	[6357]={s=1},  -- Sealed Crate
	[6358]={s=4},  -- Oily Blackmouth
	[6359]={s=5},  -- Firefin Snapper
	[6360]={s=2581},  -- Steelscale Crushfish
	[6361]={s=2},  -- Raw Rainbow Fin Albacore
	[6362]={s=4},  -- Raw Rockscale Cod
	[6363]={s=250},  -- 26 Pound Catfish
	[6364]={s=375},  -- 32 Pound Catfish
	[6365]={s=180},  -- Strong Fishing Pole
	[6367]={s=3378},  -- Big Iron Fishing Pole
	[6368]={s=100},  -- Recipe: Rainbow Fin Albacore
	[6369]={s=550},  -- Recipe: Rockscale Cod
	[6370]={s=10},  -- Blackmouth Oil
	[6371]={s=12},  -- Fire Oil
	[6372]={s=35},  -- Swim Speed Potion
	[6373]={s=35},  -- Elixir of Firepower
	[6375]={s=250},  -- Formula: Enchant Bracer - Lesser Spirit
	[6377]={s=250},  -- Formula: Enchant Boots - Minor Agility
	[6378]={s=292},  -- Seer's Cape
	[6379]={s=244},  -- Inscribed Leather Belt
	[6380]={s=654},  -- Inscribed Buckler
	[6381]={s=625},  -- Bright Cloak
	[6382]={s=523},  -- Forest Leather Belt
	[6383]={s=1519},  -- Forest Buckler
	[6384]={s=250},  -- Stylish Blue Shirt
	[6385]={s=250},  -- Stylish Green Shirt
	[6386]={s=2692},  -- Glimmering Mail Legguards
	[6387]={s=1228},  -- Glimmering Mail Bracers
	[6388]={s=2043},  -- Glimmering Mail Pauldrons
	[6389]={s=2245},  -- Glimmering Mail Coif
	[6390]={s=150},  -- Pattern: Stylish Blue Shirt
	[6391]={s=150},  -- Pattern: Stylish Green Shirt
	[6392]={s=1000},  -- Belt of Arugal
	[6393]={s=760},  -- Silver-thread Gloves
	[6394]={s=1041},  -- Silver-thread Boots
	[6395]={s=1264},  -- Silver-thread Amice
	[6396]={s=2814},  -- Emblazoned Chestpiece
	[6397]={s=985},  -- Emblazoned Gloves
	[6398]={s=989},  -- Emblazoned Belt
	[6399]={s=1639},  -- Emblazoned Shoulders
	[6400]={s=3089},  -- Glimmering Shield
	[6401]={s=275},  -- Pattern: Dark Silk Shirt
	[6402]={s=4699},  -- Mail Combat Leggings
	[6403]={s=1771},  -- Mail Combat Armguards
	[6404]={s=3242},  -- Mail Combat Spaulders
	[6405]={s=3167},  -- Nightsky Trousers
	[6406]={s=1970},  -- Nightsky Boots
	[6407]={s=1198},  -- Nightsky Wristbands
	[6408]={s=1654},  -- Insignia Gloves
	[6409]={s=1660},  -- Insignia Belt
	[6410]={s=1514},  -- Insignia Bracers
	[6411]={s=7268},  -- Chief Brigadier Armor
	[6412]={s=4711},  -- Chief Brigadier Boots
	[6413]={s=2497},  -- Chief Brigadier Bracers
	[6414]={s=2055},  -- Seal of Sylvanas
	[6415]={s=4565},  -- Aurora Robe
	[6416]={s=2728},  -- Aurora Boots
	[6417]={s=2536},  -- Aurora Cloak
	[6418]={s=1697},  -- Aurora Sash
	[6419]={s=2299},  -- Glyphed Mitts
	[6420]={s=3739},  -- Glyphed Boots
	[6421]={s=2317},  -- Glyphed Belt
	[6422]={s=3768},  -- Glyphed Helm
	[6423]={s=7233},  -- Blackforge Greaves
	[6424]={s=3825},  -- Blackforge Cape
	[6425]={s=4478},  -- Blackforge Girdle
	[6426]={s=4162},  -- Blackforge Bracers
	[6427]={s=7016},  -- Mistscape Robe
	[6428]={s=2795},  -- Mistscape Gloves
	[6429]={s=4544},  -- Mistscape Wizard Hat
	[6430]={s=9098},  -- Imperial Leather Breastplate
	[6431]={s=5436},  -- Imperial Leather Boots
	[6432]={s=3741},  -- Imperial Cloak
	[6433]={s=4953},  -- Imperial Leather Helm
	[6435]={s=0},  -- Infused Burning Gem
	[6436]={s=0},  -- Burning Gem
	[6438]={s=362},  -- Dull Elemental Bracer
	[6439]={s=237},  -- Broken Binding Bracer
	[6440]={s=15812},  -- Brainlash
	[6441]={s=0},  -- Shadowstalker Scalp
	[6442]={s=0},  -- Oracle Crystal
	[6443]={s=0},  -- Deviate Hide
	[6444]={s=228},  -- Forked Tongue
	[6445]={s=88},  -- Brittle Molting
	[6446]={s=532},  -- Snakeskin Bag
	[6447]={s=562},  -- Worn Turtle Shell Shield
	[6448]={s=1942},  -- Tail Spike
	[6449]={s=701},  -- Glowing Lizardscale Cloak
	[6450]={s=200},  -- Silk Bandage
	[6451]={s=400},  -- Heavy Silk Bandage
	[6452]={s=28},  -- Anti-Venom
	[6453]={s=62},  -- Strong Anti-Venom
	[6454]={s=225},  -- Manual: Strong Anti-Venom
	[6455]={s=4},  -- Old Wagonwheel
	[6456]={s=3},  -- Acidic Slime
	[6457]={s=4},  -- Rusted Engineering Parts
	[6458]={s=1},  -- Oil Covered Fish
	[6459]={s=934},  -- Savage Trodders
	[6460]={s=844},  -- Cobrahn's Grasp
	[6461]={s=1190},  -- Slime-encrusted Pads
	[6462]={s=0},  -- Secure Crate
	[6463]={s=1527},  -- Deep Fathom Ring
	[6464]={s=0},  -- Wailing Essence
	[6465]={s=768},  -- Robe of the Moccasin
	[6466]={s=413},  -- Deviate Scale Cloak
	[6467]={s=420},  -- Deviate Scale Gloves
	[6468]={s=658},  -- Deviate Scale Belt
	[6469]={s=2240},  -- Venomstrike
	[6470]={s=20},  -- Deviate Scale
	[6471]={s=500},  -- Perfect Deviate Scale
	[6472]={s=3018},  -- Stinging Viper
	[6473]={s=1010},  -- Armor of the Fang
	[6474]={s=137},  -- Pattern: Deviate Scale Cloak
	[6475]={s=375},  -- Pattern: Deviate Scale Gloves
	[6476]={s=500},  -- Pattern: Deviate Scale Belt
	[6477]={s=274},  -- Grassland Sash
	[6479]={s=0},  -- Malem Pendant
	[6480]={s=713},  -- Slick Deviate Leggings
	[6481]={s=641},  -- Dagmire Gauntlets
	[6482]={s=728},  -- Firewalker Boots
	[6486]={s=0},  -- Singed Scale
	[6487]={s=0},  -- Vile Familiar Head
	[6488]={s=0},  -- Simple Tablet
	[6502]={s=1140},  -- Violet Scale Armor
	[6503]={s=762},  -- Harlequin Robes
	[6504]={s=2933},  -- Wingblade
	[6505]={s=3680},  -- Crescent Staff
	[6506]={s=87},  -- Infantry Boots
	[6507]={s=44},  -- Infantry Bracers
	[6508]={s=34},  -- Infantry Cloak
	[6509]={s=44},  -- Infantry Belt
	[6510]={s=54},  -- Infantry Gauntlets
	[6511]={s=121},  -- Journeyman's Robe
	[6512]={s=191},  -- Disciple's Robe
	[6513]={s=28},  -- Disciple's Sash
	[6514]={s=42},  -- Disciple's Cloak
	[6515]={s=37},  -- Disciple's Gloves
	[6517]={s=35},  -- Pioneer Belt
	[6518]={s=70},  -- Pioneer Boots
	[6519]={s=36},  -- Pioneer Bracers
	[6520]={s=41},  -- Pioneer Cloak
	[6521]={s=47},  -- Pioneer Gloves
	[6522]={s=4},  -- Deviate Fish
	[6523]={s=284},  -- Buckled Harness
	[6524]={s=574},  -- Studded Leather Harness
	[6525]={s=1033},  -- Grunt's Harness
	[6526]={s=2497},  -- Battle Harness
	[6527]={s=187},  -- Ancestral Robe
	[6528]={s=358},  -- Spellbinder Robe
	[6529]={s=12},  -- Shiny Bauble
	[6530]={s=25},  -- Nightcrawlers
	[6531]={s=417},  -- Barbaric Cloth Robe
	[6532]={s=62},  -- Bright Baubles
	[6533]={s=62},  -- Aquadynamic Fish Attractor
	[6534]={s=0},  -- Forged Steel Bars
	[6535]={s=0},  -- Tablet of Verga
	[6536]={s=488},  -- Willow Vest
	[6537]={s=210},  -- Willow Boots
	[6538]={s=492},  -- Willow Robe
	[6539]={s=162},  -- Willow Belt
	[6540]={s=431},  -- Willow Pants
	[6541]={s=163},  -- Willow Gloves
	[6542]={s=219},  -- Willow Cape
	[6543]={s=147},  -- Willow Bracers
	[6545]={s=675},  -- Soldier's Armor
	[6546]={s=533},  -- Soldier's Leggings
	[6547]={s=267},  -- Soldier's Gauntlets
	[6548]={s=233},  -- Soldier's Girdle
	[6549]={s=101},  -- Soldier's Cloak
	[6550]={s=204},  -- Soldier's Wristguards
	[6551]={s=409},  -- Soldier's Boots
	[6552]={s=601},  -- Bard's Tunic
	[6553]={s=525},  -- Bard's Trousers
	[6554]={s=229},  -- Bard's Gloves
	[6555]={s=130},  -- Bard's Cloak
	[6556]={s=174},  -- Bard's Bracers
	[6557]={s=302},  -- Bard's Boots
	[6558]={s=180},  -- Bard's Belt
	[6559]={s=533},  -- Bard's Buckler
	[6560]={s=615},  -- Soldier's Shield
	[6561]={s=675},  -- Seer's Padded Armor
	[6562]={s=508},  -- Shimmering Boots
	[6563]={s=295},  -- Shimmering Bracers
	[6564]={s=512},  -- Shimmering Cloak
	[6565]={s=393},  -- Shimmering Gloves
	[6566]={s=411},  -- Shimmering Amice
	[6567]={s=1036},  -- Shimmering Armor
	[6568]={s=920},  -- Shimmering Trousers
	[6569]={s=1044},  -- Shimmering Robe
	[6570]={s=363},  -- Shimmering Sash
	[6571]={s=1166},  -- Scouting Buckler
	[6572]={s=1323},  -- Defender Shield
	[6573]={s=938},  -- Defender Boots
	[6574]={s=568},  -- Defender Bracers
	[6575]={s=431},  -- Defender Cloak
	[6576]={s=572},  -- Defender Girdle
	[6577]={s=649},  -- Defender Gauntlets
	[6578]={s=1302},  -- Defender Leggings
	[6579]={s=667},  -- Defender Spaulders
	[6580]={s=1312},  -- Defender Tunic
	[6581]={s=422},  -- Scouting Belt
	[6582]={s=731},  -- Scouting Boots
	[6583]={s=425},  -- Scouting Bracers
	[6584]={s=1416},  -- Scouting Tunic
	[6585]={s=558},  -- Scouting Cloak
	[6586]={s=505},  -- Scouting Gloves
	[6587]={s=1146},  -- Scouting Trousers
	[6588]={s=458},  -- Scouting Spaulders
	[6590]={s=1830},  -- Battleforge Boots
	[6591]={s=1007},  -- Battleforge Wristguards
	[6592]={s=2447},  -- Battleforge Armor
	[6593]={s=922},  -- Battleforge Cloak
	[6594]={s=1120},  -- Battleforge Girdle
	[6595]={s=1124},  -- Battleforge Gauntlets
	[6596]={s=2258},  -- Battleforge Legguards
	[6597]={s=1707},  -- Battleforge Shoulderguards
	[6598]={s=2426},  -- Dervish Buckler
	[6599]={s=2678},  -- Battleforge Shield
	[6600]={s=867},  -- Dervish Belt
	[6601]={s=1437},  -- Dervish Boots
	[6602]={s=873},  -- Dervish Bracers
	[6603]={s=2334},  -- Dervish Tunic
	[6604]={s=1200},  -- Dervish Cape
	[6605]={s=971},  -- Dervish Gloves
	[6607]={s=2202},  -- Dervish Leggings
	[6608]={s=1328},  -- Bright Armor
	[6609]={s=2148},  -- Sage's Cloth
	[6610]={s=2156},  -- Sage's Robe
	[6611]={s=812},  -- Sage's Sash
	[6612]={s=1112},  -- Sage's Boots
	[6613]={s=744},  -- Sage's Bracers
	[6614]={s=1120},  -- Sage's Cloak
	[6615]={s=824},  -- Sage's Gloves
	[6616]={s=2203},  -- Sage's Pants
	[6617]={s=1371},  -- Sage's Mantle
	[6622]={s=55400},  -- Sword of Zeal
	[6624]={s=0},  -- Ken'zigla's Draught
	[6625]={s=0},  -- Dirt-caked Pendant
	[6626]={s=0},  -- Dogran's Pendant
	[6627]={s=2620},  -- Mutant Scale Breastplate
	[6628]={s=370},  -- Raven's Claws
	[6629]={s=630},  -- Sporid Cape
	[6630]={s=2067},  -- Seedcloud Buckler
	[6631]={s=4053},  -- Living Root
	[6632]={s=642},  -- Feyscale Cloak
	[6633]={s=2131},  -- Butcher's Slicer
	[6634]={s=0},  -- Ritual Salve
	[6635]={s=0},  -- Earth Sapta
	[6636]={s=0},  -- Fire Sapta
	[6637]={s=0},  -- Water Sapta
	[6640]={s=0},  -- Felstalker Hoof
	[6641]={s=3675},  -- Haunting Blade
	[6642]={s=1880},  -- Phantom Armor
	[6643]={s=6},  -- Bloated Smallfish
	[6645]={s=25},  -- Bloated Mud Snapper
	[6652]={s=0},  -- Reagent Pouch
	[6653]={s=0},  -- Torch of the Dormant Flame
	[6654]={s=0},  -- Torch of the Eternal Flame
	[6655]={s=0},  -- Glowing Ember
	[6656]={s=0},  -- Rough Quartz
	[6657]={s=5},  -- Savory Deviate Delight
	[6658]={s=0},  -- Example Collar
	[6659]={s=541},  -- Scarab Trousers
	[6660]={s=36157},  -- Julie's Dagger
	[6661]={s=115},  -- Recipe: Savory Deviate Delight
	[6662]={s=95},  -- Elixir of Giant Growth
	[6663]={s=150},  -- Recipe: Elixir of Giant Growth
	[6664]={s=892},  -- Voodoo Mantle
	[6665]={s=895},  -- Hexed Bracers
	[6666]={s=830},  -- Dredge Boots
	[6667]={s=992},  -- Engineer's Cloak
	[6668]={s=1245},  -- Draftsman Boots
	[6669]={s=1378},  -- Sacred Band
	[6670]={s=1672},  -- Panther Armor
	[6671]={s=2068},  -- Juggernaut Leggings
	[6672]={s=500},  -- Schematic: Flash Bomb
	[6675]={s=1048},  -- Tempered Bracers
	[6676]={s=2245},  -- Constable Buckler
	[6677]={s=2401},  -- Spellcrafter Wand
	[6678]={s=677},  -- Band of Elven Grace
	[6679]={s=4852},  -- Armor Piercer
	[6681]={s=3124},  -- Thornspike
	[6682]={s=1900},  -- Death Speaker Robes
	[6684]={s=0},  -- Snufflenose Command Stick
	[6685]={s=1310},  -- Death Speaker Mantle
	[6686]={s=2627},  -- Tusken Helm
	[6687]={s=9930},  -- Corpsemaker
	[6688]={s=2059},  -- Whisperwind Headdress
	[6689]={s=8267},  -- Wind Spirit Staff
	[6690]={s=3346},  -- Ferine Leggings
	[6691]={s=8866},  -- Swinetusk Shank
	[6692]={s=9788},  -- Pronged Reaver
	[6693]={s=1816},  -- Agamaggan's Clutch
	[6694]={s=6309},  -- Heart of Agamaggan
	[6695]={s=3002},  -- Stygian Bone Amulet
	[6696]={s=5086},  -- Nightstalker Bow
	[6697]={s=2041},  -- Batwing Mantle
	[6709]={s=545},  -- Moonglow Vest
	[6710]={s=137},  -- Pattern: Moonglow Vest
	[6712]={s=12},  -- Practice Lock
	[6713]={s=10},  -- Ripped Pants
	[6714]={s=75},  -- Ez-Thro Dynamite
	[6715]={s=21},  -- Ruined Jumper Cables
	[6716]={s=200},  -- Schematic: EZ-Thro Dynamite
	[6717]={s=0},  -- Gaffer Jack
	[6718]={s=0},  -- Electropeller
	[6719]={s=1097},  -- Windborne Belt
	[6720]={s=3218},  -- Spirit Hunter Headdress
	[6721]={s=1418},  -- Chestplate of Kor
	[6722]={s=1331},  -- Beastial Manacles
	[6723]={s=8155},  -- Medal of Courage
	[6725]={s=6105},  -- Marbled Buckler
	[6726]={s=2388},  -- Razzeric's Customized Seatbelt
	[6727]={s=2996},  -- Razzeric's Racing Grips
	[6729]={s=7187},  -- Fizzle's Zippy Lighter
	[6731]={s=871},  -- Ironforge Breastplate
	[6732]={s=2421},  -- Gnomish Mechanic's Gloves
	[6735]={s=150},  -- Plans: Ironforge Breastplate
	[6737]={s=2805},  -- Dryleaf Pants
	[6738]={s=7040},  -- Bleeding Crescent
	[6739]={s=2991},  -- Cliffrunner's Aim
	[6740]={s=1000},  -- Azure Sash
	[6741]={s=3014},  -- Orcish War Sword
	[6742]={s=2830},  -- Stonefist Girdle
	[6743]={s=1462},  -- Sustaining Ring
	[6744]={s=1190},  -- Gloves of Kapelan
	[6745]={s=2239},  -- Swiftrunner Cape
	[6746]={s=7075},  -- Basalt Buckler
	[6747]={s=5015},  -- Enforcer Pauldrons
	[6748]={s=897},  -- Monkey Ring
	[6749]={s=897},  -- Tiger Band
	[6750]={s=897},  -- Snake Hoop
	[6751]={s=1411},  -- Mourning Shawl
	[6752]={s=1601},  -- Lancer Boots
	[6753]={s=0},  -- Feather Charm
	[6755]={s=0},  -- A Small Container of Gems
	[6756]={s=1375},  -- Jewelry Box
	[6757]={s=4630},  -- Jaina's Signet Ring
	[6766]={s=0},  -- Flayed Demon Skin
	[6767]={s=0},  -- Tyranis' Pendant
	[6773]={s=7366},  -- Gelkis Marauder Chain
	[6774]={s=2885},  -- Uthek's Finger
	[6775]={s=0},  -- Tome of Divinity
	[6776]={s=0},  -- Tome of Valor
	[6780]={s=1560},  -- Lilac Sash
	[6781]={s=0},  -- Bartleby's Mug
	[6782]={s=0},  -- Marshal Haggard's Badge
	[6783]={s=0},  -- Dead-tooth's Key
	[6784]={s=2031},  -- Braced Handguards
	[6785]={s=0},  -- Powers of the Void
	[6786]={s=59},  -- Simple Dress
	[6787]={s=466},  -- White Woolen Dress
	[6788]={s=3331},  -- Magram Hunter's Belt
	[6789]={s=4012},  -- Ceremonial Centaur Blanket
	[6790]={s=1540},  -- Ring of Calm
	[6791]={s=3464},  -- Hellion Boots
	[6792]={s=4738},  -- Sanguine Pauldrons
	[6793]={s=3157},  -- Auric Bracers
	[6794]={s=2641},  -- Stormfire Gauntlets
	[6795]={s=500},  -- White Swashbuckler's Shirt
	[6796]={s=750},  -- Red Swashbuckler's Shirt
	[6797]={s=6362},  -- Eyepoker
	[6798]={s=6386},  -- Blasting Hackbut
	[6799]={s=0},  -- Vejrek's Head
	[6800]={s=0},  -- Umbral Ore
	[6801]={s=4456},  -- Baroque Apron
	[6802]={s=18255},  -- Sword of Omen
	[6803]={s=4885},  -- Prophetic Cane
	[6804]={s=11262},  -- Windstorm Hammer
	[6805]={s=0},  -- Horn of Vorlus
	[6806]={s=8507},  -- Dancing Flame
	[6807]={s=62},  -- Frog Leg Stew
	[6808]={s=0},  -- Elunite Ore
	[6809]={s=0},  -- Elura's Medallion
	[6810]={s=0},  -- Surena's Choker
	[6811]={s=25},  -- Aquadynamic Fish Lens
	[6812]={s=0},  -- Case of Elunite
	[6826]={s=548},  -- Brilliant Scale
	[6827]={s=150},  -- Box of Supplies
	[6828]={s=6268},  -- Visionary Buckler
	[6829]={s=18714},  -- Sword of Serenity
	[6830]={s=23476},  -- Bonebiter
	[6831]={s=17522},  -- Black Menace
	[6832]={s=3769},  -- Cloak of Blight
	[6833]={s=500},  -- White Tuxedo Shirt
	[6835]={s=504},  -- Black Tuxedo Pants
	[6838]={s=0},  -- Scorched Spider Fang
	[6839]={s=0},  -- Charred Horn
	[6840]={s=0},  -- Galvanized Horn
	[6841]={s=0},  -- Vial of Phlogiston
	[6842]={s=0},  -- Furen's Instructions
	[6843]={s=0},  -- Cask of Scalder
	[6844]={s=0},  -- Burning Blood
	[6845]={s=0},  -- Burning Rock
	[6846]={s=0},  -- Defias Script
	[6847]={s=0},  -- Dark Iron Script
	[6848]={s=0},  -- Searing Coral
	[6849]={s=0},  -- Sunscorched Shell
	[6851]={s=0},  -- Essence of the Exile
	[6866]={s=0},  -- Symbol of Life
	[6887]={s=5},  -- Spotted Yellowtail
	[6888]={s=10},  -- Herb Baked Egg
	[6889]={s=4},  -- Small Egg
	[6890]={s=6},  -- Smoked Bear Meat
	[6892]={s=62},  -- Recipe: Smoked Bear Meat
	[6893]={s=0},  -- Workshop Key
	[6894]={s=0},  -- Whirlwind Heart
	[6895]={s=0},  -- Jordan's Smithing Hammer
	[6898]={s=4132},  -- Orb of Soran'ruk
	[6900]={s=4685},  -- Enchanted Gold Bloodrobe
	[6901]={s=1523},  -- Glowing Thresher Cape
	[6902]={s=877},  -- Bands of Serra'kis
	[6903]={s=1549},  -- Gaze Dreamer Pants
	[6904]={s=4665},  -- Bite of Serra'kis
	[6905]={s=4010},  -- Reef Axe
	[6906]={s=1275},  -- Algae Fists
	[6907]={s=1872},  -- Tortoise Armor
	[6908]={s=522},  -- Ghamoo-ra's Bind
	[6909]={s=7155},  -- Strike of the Hydra
	[6910]={s=2298},  -- Leech Pants
	[6911]={s=1442},  -- Moss Cinch
	[6912]={s=0},  -- Heartswood
	[6913]={s=0},  -- Heartswood Core
	[6914]={s=0},  -- Soran'ruk Fragment
	[6915]={s=0},  -- Large Soran'ruk Fragment
	[6916]={s=0},  -- Tome of Divinity
	[6926]={s=0},  -- Furen's Notes
	[6927]={s=0},  -- Big Will's Ear
	[6928]={s=0},  -- Bloodstone Choker
	[6929]={s=0},  -- Bath'rah's Parchment
	[6930]={s=0},  -- Rod of Channeling
	[6931]={s=0},  -- Moldy Tome
	[6947]={s=5},  -- Instant Poison
	[6948]={s=0},  -- Hearthstone
	[6949]={s=20},  -- Instant Poison II
	[6950]={s=30},  -- Instant Poison III
	[6951]={s=75},  -- Mind-numbing Poison II
	[6952]={s=0},  -- Thick Bear Fur
	[6953]={s=7459},  -- Verigan's Fist
	[6966]={s=693},  -- Elunite Axe
	[6967]={s=696},  -- Elunite Sword
	[6968]={s=698},  -- Elunite Hammer
	[6969]={s=701},  -- Elunite Dagger
	[6970]={s=906},  -- Furen's Favor
	[6971]={s=2221},  -- Fire Hardened Coif
	[6972]={s=3242},  -- Fire Hardened Hauberk
	[6973]={s=2465},  -- Fire Hardened Leggings
	[6974]={s=1497},  -- Fire Hardened Gauntlets
	[6975]={s=16766},  -- Whirlwind Axe
	[6976]={s=17264},  -- Whirlwind Warhammer
	[6977]={s=17325},  -- Whirlwind Sword
	[6978]={s=672},  -- Umbral Axe
	[6979]={s=675},  -- Haggard's Axe
	[6980]={s=677},  -- Haggard's Dagger
	[6981]={s=680},  -- Umbral Dagger
	[6982]={s=683},  -- Umbral Mace
	[6983]={s=685},  -- Haggard's Hammer
	[6984]={s=688},  -- Umbral Sword
	[6985]={s=690},  -- Haggard's Sword
	[6986]={s=50},  -- Crimson Lotus
	[6987]={s=13},  -- Fish Scale
	[6989]={s=0},  -- Vial of Hatefury Blood
	[6990]={s=0},  -- Lesser Infernal Stone
	[6991]={s=0},  -- Smoldering Coal
	[6992]={s=0},  -- Jordan's Ore Shipment
	[6993]={s=0},  -- Jordan's Refined Ore Shipment
	[6994]={s=0},  -- Whitestone Oak Lumber
	[6995]={s=0},  -- Corrupted Kor Gem
	[6996]={s=0},  -- Jordan's Weapon Notes
	[6997]={s=0},  -- Tattered Manuscript
	[6998]={s=774},  -- Nimbus Boots
	[6999]={s=0},  -- Tome of the Cabal
	[7000]={s=650},  -- Heartwood Girdle
	[7001]={s=3535},  -- Gravestone Scepter
	[7002]={s=3028},  -- Arctic Buckler
	[7003]={s=981},  -- Beetle Clasps
	[7004]={s=984},  -- Prelacy Cape
	[7005]={s=16},  -- Skinning Knife
	[7006]={s=0},  -- Reconstructed Tome
	[7026]={s=22},  -- Linen Belt
	[7046]={s=1494},  -- Azure Silk Pants
	[7047]={s=824},  -- Hands of Darkness
	[7048]={s=745},  -- Azure Silk Hood
	[7049]={s=914},  -- Truefaith Gloves
	[7050]={s=999},  -- Silk Headband
	[7051]={s=2696},  -- Earthen Vest
	[7052]={s=1488},  -- Azure Silk Belt
	[7053]={s=2240},  -- Azure Silk Cloak
	[7054]={s=4700},  -- Robe of Power
	[7055]={s=1503},  -- Crimson Silk Belt
	[7056]={s=2314},  -- Crimson Silk Cloak
	[7057]={s=2323},  -- Green Silken Shoulders
	[7058]={s=2052},  -- Crimson Silk Vest
	[7059]={s=2781},  -- Crimson Silk Shoulders
	[7060]={s=2791},  -- Azure Shoulders
	[7061]={s=2017},  -- Earthen Silk Belt
	[7062]={s=2430},  -- Crimson Silk Pantaloons
	[7063]={s=4741},  -- Crimson Silk Robe
	[7064]={s=2569},  -- Crimson Silk Gloves
	[7065]={s=2398},  -- Green Silk Armor
	[7067]={s=400},  -- Elemental Earth
	[7068]={s=400},  -- Elemental Fire
	[7069]={s=400},  -- Elemental Air
	[7070]={s=400},  -- Elemental Water
	[7071]={s=100},  -- Iron Buckle
	[7072]={s=150},  -- Naga Scale
	[7073]={s=6},  -- Broken Fang
	[7074]={s=4},  -- Chipped Claw
	[7075]={s=400},  -- Core of Earth
	[7076]={s=400},  -- Essence of Earth
	[7077]={s=400},  -- Heart of Fire
	[7078]={s=400},  -- Essence of Fire
	[7079]={s=400},  -- Globe of Water
	[7080]={s=400},  -- Essence of Water
	[7081]={s=400},  -- Breath of Wind
	[7082]={s=400},  -- Essence of Air
	[7083]={s=0},  -- Purified Kor Gem
	[7084]={s=350},  -- Pattern: Crimson Silk Shoulders
	[7085]={s=350},  -- Pattern: Azure Shoulders
	[7086]={s=375},  -- Pattern: Earthen Silk Belt
	[7087]={s=300},  -- Pattern: Crimson Silk Cloak
	[7088]={s=1250},  -- Pattern: Crimson Silk Robe
	[7089]={s=375},  -- Pattern: Azure Silk Cloak
	[7090]={s=250},  -- Pattern: Green Silk Armor
	[7091]={s=250},  -- Pattern: Truefaith Gloves
	[7092]={s=250},  -- Pattern: Hands of Darkness
	[7094]={s=174},  -- Driftwood Branch
	[7095]={s=32},  -- Bog Boots
	[7096]={s=5},  -- Plucked Feather
	[7097]={s=1},  -- Leg Meat
	[7098]={s=6},  -- Splintered Tusk
	[7099]={s=6},  -- Severed Pincer
	[7100]={s=7},  -- Sticky Ichor
	[7101]={s=5},  -- Bug Eye
	[7106]={s=1234},  -- Zodiac Gloves
	[7107]={s=1858},  -- Belt of the Stars
	[7108]={s=209},  -- Infantry Shield
	[7109]={s=74},  -- Pioneer Buckler
	[7110]={s=2069},  -- Silver-thread Armor
	[7111]={s=3329},  -- Nightsky Armor
	[7112]={s=4547},  -- Aurora Armor
	[7113]={s=6707},  -- Mistscape Armor
	[7114]={s=250},  -- Pattern: Azure Silk Gloves
	[7115]={s=683},  -- Heirloom Axe
	[7116]={s=685},  -- Heirloom Dagger
	[7117]={s=688},  -- Heirloom Hammer
	[7118]={s=690},  -- Heirloom Sword
	[7119]={s=0},  -- Twitching Antenna
	[7120]={s=895},  -- Ruga's Bulwark
	[7126]={s=0},  -- Smokey Iron Ingot
	[7127]={s=0},  -- Powdered Azurite
	[7128]={s=0},  -- Uncloven Satyr Hoof
	[7129]={s=1546},  -- Brutal Gauntlets
	[7130]={s=2328},  -- Brutal Helm
	[7131]={s=0},  -- Dragonmaw Shinbone
	[7132]={s=2338},  -- Brutal Legguards
	[7133]={s=3098},  -- Brutal Hauberk
	[7134]={s=0},  -- Sturdy Dragonmaw Shinbone
	[7135]={s=0},  -- Broken Dragonmaw Shinbone
	[7146]={s=0},  -- The Scarlet Key
	[7148]={s=21},  -- Goblin Jumper Cables
	[7166]={s=194},  -- Copper Dagger
	[7189]={s=4712},  -- Goblin Rocket Boots
	[7190]={s=0},  -- Scorched Rocket Boots
	[7191]={s=0},  -- Fused Wiring
	[7206]={s=0},  -- Mirror Lake Water Sample
	[7207]={s=0},  -- Jennea's Flask
	[7208]={s=0},  -- Tazan's Key
	[7209]={s=0},  -- Tazan's Satchel
	[7226]={s=0},  -- Mage-tastic Gizmonitor
	[7227]={s=0},  -- Balnir Snapdragons
	[7228]={s=25},  -- Tigule and Foror's Strawberry Ice Cream
	[7229]={s=285},  -- Explorer's Vest
	[7230]={s=3103},  -- Smite's Mighty Hammer
	[7231]={s=0},  -- Astor's Letter of Introduction
	[7247]={s=0},  -- Chest of Containment Coffers
	[7249]={s=0},  -- Charged Rift Gem
	[7266]={s=0},  -- Ur's Treatise on Shadow Magic
	[7267]={s=0},  -- Pristine Spider Silk
	[7268]={s=0},  -- Xavian Water Sample
	[7269]={s=0},  -- Deino's Flask
	[7270]={s=0},  -- Laughing Sister's Hair
	[7271]={s=0},  -- Flawless Ivory Tusk
	[7272]={s=0},  -- Bolt Charged Bramble
	[7273]={s=0},  -- Witherbark Totem Stick
	[7274]={s=0},  -- Rituals of Power
	[7276]={s=34},  -- Handstitched Leather Cloak
	[7277]={s=28},  -- Handstitched Leather Bracers
	[7278]={s=25},  -- Light Leather Quiver
	[7279]={s=25},  -- Small Leather Ammo Pouch
	[7280]={s=162},  -- Rugged Leather Pants
	[7281]={s=84},  -- Light Leather Bracers
	[7282]={s=599},  -- Light Leather Pants
	[7283]={s=519},  -- Black Whelp Cloak
	[7284]={s=586},  -- Red Whelp Gloves
	[7285]={s=588},  -- Nimble Leather Gloves
	[7286]={s=25},  -- Black Whelp Scale
	[7287]={s=100},  -- Red Whelp Scale
	[7288]={s=125},  -- Pattern: Rugged Leather Pants
	[7289]={s=162},  -- Pattern: Black Whelp Cloak
	[7290]={s=400},  -- Pattern: Red Whelp Gloves
	[7291]={s=0},  -- Infernal Orb
	[7292]={s=0},  -- Filled Containment Coffer
	[7293]={s=0},  -- Dalaran Mana Gem
	[7294]={s=0},  -- Andron's Ledger
	[7295]={s=0},  -- Tazan's Logbook
	[7296]={s=56},  -- Extinguished Torch
	[7297]={s=0},  -- Morbent's Bane
	[7298]={s=468},  -- Blade of Cunning
	[7306]={s=0},  -- Fenwick's Head
	[7307]={s=62},  -- Flesh Eating Worm
	[7308]={s=0},  -- Cantation of Manifestation
	[7309]={s=0},  -- Dalaran Status Report
	[7326]={s=696},  -- Thun'grim's Axe
	[7327]={s=698},  -- Thun'grim's Dagger
	[7328]={s=701},  -- Thun'grim's Mace
	[7329]={s=703},  -- Thun'grim's Sword
	[7330]={s=3923},  -- Infiltrator Buckler
	[7331]={s=4330},  -- Phalanx Shield
	[7332]={s=6692},  -- Regal Armor
	[7333]={s=0},  -- Overseer's Whistle
	[7334]={s=1544},  -- Efflorescent Robe
	[7335]={s=1937},  -- Grizzly Tunic
	[7336]={s=1509},  -- Wildwood Chain
	[7337]={s=250000},  -- The Rock
	[7338]={s=2500},  -- Mood Ring
	[7339]={s=62500},  -- Miniscule Diamond Ring
	[7340]={s=125000},  -- Flawless Diamond Solitaire
	[7341]={s=12500},  -- Cubic Zirconia Ring
	[7342]={s=25000},  -- Silver Piffeny Band
	[7343]={s=0},  -- Bingles's Wrench
	[7344]={s=5000},  -- Torch of Holy Flame
	[7345]={s=0},  -- Bingles's Screwdriver
	[7346]={s=0},  -- Bingles's Hammer
	[7348]={s=690},  -- Fletcher's Gloves
	[7349]={s=861},  -- Herbalist's Gloves
	[7350]={s=29},  -- Disciple's Bracers
	[7351]={s=58},  -- Disciple's Boots
	[7352]={s=1306},  -- Earthen Leather Shoulders
	[7353]={s=2998},  -- Elder's Padded Armor
	[7354]={s=1864},  -- Elder's Boots
	[7355]={s=1031},  -- Elder's Bracers
	[7356]={s=1411},  -- Elder's Cloak
	[7357]={s=1875},  -- Elder's Hat
	[7358]={s=885},  -- Pilferer's Gloves
	[7359]={s=978},  -- Heavy Earthen Gloves
	[7360]={s=400},  -- Pattern: Dark Leather Gloves
	[7361]={s=450},  -- Pattern: Herbalist's Gloves
	[7362]={s=500},  -- Pattern: Earthen Leather Shoulders
	[7363]={s=525},  -- Pattern: Pilferer's Gloves
	[7364]={s=550},  -- Pattern: Heavy Earthen Gloves
	[7365]={s=0},  -- Gnoam Sprecklesprocket
	[7366]={s=1098},  -- Elder's Gloves
	[7367]={s=1818},  -- Elder's Mantle
	[7368]={s=2677},  -- Elder's Pants
	[7369]={s=2955},  -- Elder's Robe
	[7370]={s=1012},  -- Elder's Sash
	[7371]={s=500},  -- Heavy Quiver
	[7372]={s=500},  -- Heavy Leather Ammo Pouch
	[7373]={s=3097},  -- Dusky Leather Leggings
	[7374]={s=3760},  -- Dusky Leather Armor
	[7375]={s=3773},  -- Green Whelp Armor
	[7376]={s=0},  -- Bingles's Blastencapper
	[7377]={s=2269},  -- Frost Leather Cloak
	[7378]={s=2146},  -- Dusky Bracers
	[7386]={s=2387},  -- Green Whelp Bracers
	[7387]={s=2587},  -- Dusky Belt
	[7389]={s=0},  -- Venture Co. Ledger
	[7390]={s=4237},  -- Dusky Boots
	[7391]={s=4253},  -- Swift Boots
	[7392]={s=200},  -- Green Whelp Scale
	[7406]={s=1372},  -- Infiltrator Cord
	[7407]={s=3666},  -- Infiltrator Armor
	[7408]={s=2281},  -- Infiltrator Shoulders
	[7409]={s=2289},  -- Infiltrator Boots
	[7410]={s=1174},  -- Infiltrator Bracers
	[7411]={s=1769},  -- Infiltrator Cloak
	[7412]={s=1302},  -- Infiltrator Gloves
	[7413]={s=2157},  -- Infiltrator Cap
	[7414]={s=3175},  -- Infiltrator Pants
	[7415]={s=1484},  -- Dervish Spaulders
	[7416]={s=1442},  -- Phalanx Bracers
	[7417]={s=2903},  -- Phalanx Boots
	[7418]={s=4256},  -- Phalanx Breastplate
	[7419]={s=1326},  -- Phalanx Cloak
	[7420]={s=2658},  -- Phalanx Headguard
	[7421]={s=1778},  -- Phalanx Gauntlets
	[7422]={s=1622},  -- Phalanx Girdle
	[7423]={s=3941},  -- Phalanx Leggings
	[7424]={s=2709},  -- Phalanx Spaulders
	[7428]={s=250},  -- Shadowcat Hide
	[7429]={s=4620},  -- Twilight Armor
	[7430]={s=4194},  -- Twilight Robe
	[7431]={s=3899},  -- Twilight Pants
	[7432]={s=2717},  -- Twilight Cowl
	[7433]={s=1684},  -- Twilight Gloves
	[7434]={s=2536},  -- Twilight Boots
	[7435]={s=2749},  -- Twilight Mantle
	[7436]={s=2111},  -- Twilight Cape
	[7437]={s=1554},  -- Twilight Cuffs
	[7438]={s=1560},  -- Twilight Belt
	[7439]={s=5425},  -- Sentinel Breastplate
	[7440]={s=5042},  -- Sentinel Trousers
	[7441]={s=3514},  -- Sentinel Cap
	[7442]={s=0},  -- Gyromast's Key
	[7443]={s=2243},  -- Sentinel Gloves
	[7444]={s=3377},  -- Sentinel Boots
	[7445]={s=3660},  -- Sentinel Shoulders
	[7446]={s=3092},  -- Sentinel Cloak
	[7447]={s=2068},  -- Sentinel Bracers
	[7448]={s=2076},  -- Sentinel Girdle
	[7449]={s=625},  -- Pattern: Dusky Leather Leggings
	[7450]={s=500},  -- Pattern: Green Whelp Armor
	[7451]={s=700},  -- Pattern: Green Whelp Bracers
	[7452]={s=875},  -- Pattern: Dusky Boots
	[7453]={s=875},  -- Pattern: Swift Boots
	[7454]={s=5915},  -- Knight's Breastplate
	[7455]={s=5937},  -- Knight's Legguards
	[7456]={s=4139},  -- Knight's Headguard
	[7457]={s=2564},  -- Knight's Gauntlets
	[7458]={s=3983},  -- Knight's Boots
	[7459]={s=4317},  -- Knight's Pauldrons
	[7460]={s=2000},  -- Knight's Cloak
	[7461]={s=2429},  -- Knight's Bracers
	[7462]={s=2682},  -- Knight's Girdle
	[7463]={s=6202},  -- Sentinel Buckler
	[7464]={s=0},  -- Glyphs of Summoning
	[7465]={s=6747},  -- Knight's Crest
	[7468]={s=6763},  -- Regal Robe
	[7469]={s=6284},  -- Regal Leggings
	[7470]={s=3668},  -- Regal Wizard Hat
	[7471]={s=2455},  -- Regal Gloves
	[7472]={s=3423},  -- Regal Boots
	[7473]={s=3710},  -- Regal Mantle
	[7474]={s=3281},  -- Regal Cloak
	[7475]={s=2371},  -- Regal Cuffs
	[7476]={s=2203},  -- Regal Sash
	[7477]={s=8124},  -- Ranger Tunic
	[7478]={s=6991},  -- Ranger Leggings
	[7479]={s=4873},  -- Ranger Helm
	[7480]={s=3019},  -- Ranger Gloves
	[7481]={s=4908},  -- Ranger Boots
	[7482]={s=4926},  -- Ranger Shoulders
	[7483]={s=4238},  -- Ranger Cloak
	[7484]={s=3062},  -- Ranger Wristguards
	[7485]={s=3073},  -- Ranger Cord
	[7486]={s=9325},  -- Captain's Breastplate
	[7487]={s=8665},  -- Captain's Leggings
	[7488]={s=6038},  -- Captain's Circlet
	[7489]={s=3740},  -- Captain's Gauntlets
	[7490]={s=5680},  -- Captain's Boots
	[7491]={s=6158},  -- Captain's Shoulderguards
	[7492]={s=3015},  -- Captain's Cloak
	[7493]={s=3268},  -- Captain's Bracers
	[7494]={s=3543},  -- Captain's Waistguard
	[7495]={s=9558},  -- Captain's Buckler
	[7496]={s=8882},  -- Field Plate Shield
	[7498]={s=0},  -- Top of Gelkak's Key
	[7499]={s=0},  -- Middle of Gelkak's Key
	[7500]={s=0},  -- Bottom of Gelkak's Key
	[7506]={s=500},  -- Gnomish Universal Remote
	[7507]={s=400},  -- Arcane Orb
	[7508]={s=400},  -- Ley Orb
	[7509]={s=275},  -- Manaweave Robe
	[7510]={s=276},  -- Spellfire Robes
	[7511]={s=1203},  -- Astral Knot Robe
	[7512]={s=1207},  -- Nether-lace Robe
	[7513]={s=8171},  -- Ragefire Wand
	[7514]={s=8201},  -- Icefury Wand
	[7515]={s=5382},  -- Celestial Orb
	[7516]={s=0},  -- Tabetha's Instructions
	[7517]={s=9372},  -- Gossamer Tunic
	[7518]={s=9406},  -- Gossamer Robe
	[7519]={s=7635},  -- Gossamer Pants
	[7520]={s=5747},  -- Gossamer Headpiece
	[7521]={s=3560},  -- Gossamer Gloves
	[7522]={s=4962},  -- Gossamer Boots
	[7523]={s=4993},  -- Gossamer Shoulderpads
	[7524]={s=4297},  -- Gossamer Cape
	[7525]={s=3106},  -- Gossamer Bracers
	[7526]={s=3367},  -- Gossamer Belt
	[7527]={s=11284},  -- Cabalist Chestpiece
	[7528]={s=9894},  -- Cabalist Leggings
	[7529]={s=6897},  -- Cabalist Helm
	[7530]={s=4273},  -- Cabalist Gloves
	[7531]={s=6434},  -- Cabalist Boots
	[7532]={s=6975},  -- Cabalist Spaulders
	[7533]={s=5557},  -- Cabalist Cloak
	[7534]={s=4016},  -- Cabalist Bracers
	[7535]={s=4353},  -- Cabalist Belt
	[7536]={s=13048},  -- Champion's Wall Shield
	[7537]={s=14012},  -- Gothic Shield
	[7538]={s=12322},  -- Champion's Armor
	[7539]={s=12692},  -- Champion's Leggings
	[7540]={s=8845},  -- Champion's Helmet
	[7541]={s=5479},  -- Champion's Gauntlets
	[7542]={s=8284},  -- Champion's Greaves
	[7543]={s=8123},  -- Champion's Pauldrons
	[7544]={s=4296},  -- Champion's Cape
	[7545]={s=4658},  -- Champion's Bracers
	[7546]={s=5050},  -- Champion's Girdle
	[7552]={s=2542},  -- Falcon's Hook
	[7553]={s=2542},  -- Band of the Unicorn
	[7554]={s=1039},  -- Willow Branch
	[7555]={s=7123},  -- Regal Star
	[7556]={s=5387},  -- Twilight Orb
	[7557]={s=7596},  -- Gossamer Rod
	[7558]={s=1609},  -- Shimmering Stave
	[7559]={s=666},  -- Runic Cane
	[7560]={s=300},  -- Schematic: Gnomish Universal Remote
	[7561]={s=500},  -- Schematic: Goblin Jumper Cables
	[7566]={s=0},  -- Agamand Family Sword
	[7567]={s=0},  -- Agamand Family Axe
	[7568]={s=0},  -- Agamand Family Dagger
	[7569]={s=0},  -- Agamand Family Mace
	[7586]={s=0},  -- Tharnariun's Hope
	[7587]={s=0},  -- Thun'grim's Instructions
	[7606]={s=557},  -- Polar Gauntlets
	[7607]={s=1399},  -- Sable Wand
	[7608]={s=1106},  -- Seer's Fine Stein
	[7609]={s=4210},  -- Elder's Amber Stave
	[7610]={s=5811},  -- Aurora Sphere
	[7611]={s=7364},  -- Mistscape Stave
	[7613]={s=500},  -- Pattern: Green Leather Armor
	[7626]={s=0},  -- Bundle of Furs
	[7627]={s=0},  -- Dolanaar Delivery
	[7628]={s=0},  -- Nondescript Letter
	[7629]={s=0},  -- Ukor's Burden
	[7646]={s=0},  -- Crate of Inn Supplies
	[7666]={s=0},  -- Shattered Necklace
	[7667]={s=0},  -- Talvash's Phial of Scrying
	[7668]={s=0},  -- Bloodstained Journal
	[7669]={s=0},  -- Shattered Necklace Ruby
	[7670]={s=0},  -- Shattered Necklace Sapphire
	[7671]={s=0},  -- Shattered Necklace Topaz
	[7672]={s=0},  -- Shattered Necklace Power Source
	[7673]={s=8990},  -- Talvash's Enhancing Necklace
	[7674]={s=0},  -- Delivery to Mathias
	[7675]={s=0},  -- Defias Shipping Schedule
	[7676]={s=30},  -- Thistle Tea
	[7678]={s=50},  -- Recipe: Thistle Tea
	[7679]={s=0},  -- Shrike Bat Fang
	[7680]={s=0},  -- Jadespine Basilisk Scale
	[7682]={s=7678},  -- Torturing Poker
	[7683]={s=3958},  -- Bloody Brass Knuckles
	[7684]={s=2184},  -- Bloodmage Mantle
	[7685]={s=5468},  -- Orb of the Forgotten Seer
	[7686]={s=4308},  -- Ironspine's Eye
	[7687]={s=8836},  -- Ironspine's Fist
	[7688]={s=5320},  -- Ironspine's Ribcage
	[7689]={s=11124},  -- Morbid Dawn
	[7690]={s=2232},  -- Ebon Vise
	[7691]={s=2689},  -- Embalmed Shroud
	[7708]={s=6649},  -- Necrotic Wand
	[7709]={s=3559},  -- Blighted Leggings
	[7710]={s=12279},  -- Loksey's Training Stick
	[7711]={s=1171},  -- Robe of Doan
	[7712]={s=881},  -- Mantle of Doan
	[7713]={s=4777},  -- Illusionary Rod
	[7714]={s=3834},  -- Hypnotic Blade
	[7715]={s=0},  -- Onin's Report
	[7717]={s=18923},  -- Ravager
	[7718]={s=6867},  -- Herod's Shoulder
	[7719]={s=6863},  -- Raging Berserker's Helm
	[7720]={s=5356},  -- Whitemane's Chapeau
	[7721]={s=17922},  -- Hand of Righteousness
	[7722]={s=9295},  -- Triune Amulet
	[7723]={s=22567},  -- Mograine's Might
	[7724]={s=5436},  -- Gauntlets of Divinity
	[7726]={s=11681},  -- Aegis of the Scarlet Commander
	[7727]={s=2488},  -- Watchman Pauldrons
	[7728]={s=3223},  -- Beguiler Robes
	[7729]={s=5514},  -- Chesterfall Musket
	[7730]={s=10146},  -- Cobalt Crusher
	[7731]={s=3482},  -- Ghostshard Talisman
	[7733]={s=0},  -- Staff of Prehistoria
	[7734]={s=15495},  -- Six Demon Bag
	[7735]={s=0},  -- Jannok's Rose
	[7736]={s=11970},  -- Fight Club
	[7737]={s=0},  -- Sethir's Journal
	[7738]={s=211},  -- Evergreen Gloves
	[7739]={s=480},  -- Timberland Cape
	[7740]={s=0},  -- Gni'kiv Medallion
	[7741]={s=0},  -- The Shaft of Tsol
	[7742]={s=600},  -- Schematic: Gnomish Cloaking Device
	[7746]={s=8430},  -- Explorers' League Commendation
	[7747]={s=7754},  -- Vile Protector
	[7748]={s=10862},  -- Forcestone Buckler
	[7749]={s=4885},  -- Omega Orb
	[7750]={s=1712},  -- Mantle of Woe
	[7751]={s=1614},  -- Vorrel's Boots
	[7752]={s=6902},  -- Dreamslayer
	[7753]={s=7874},  -- Bloodspiller
	[7754]={s=1959},  -- Harbinger Boots
	[7755]={s=4140},  -- Flintrock Shoulders
	[7756]={s=1606},  -- Dog Training Gloves
	[7757]={s=12874},  -- Windweaver Staff
	[7758]={s=15074},  -- Ruthless Shiv
	[7759]={s=6723},  -- Archon Chestpiece
	[7760]={s=6074},  -- Warchief Kilt
	[7761]={s=11290},  -- Steelclaw Reaver
	[7766]={s=0},  -- Empty Brown Waterskin
	[7767]={s=0},  -- Empty Blue Waterskin
	[7768]={s=0},  -- Empty Red Waterskin
	[7769]={s=0},  -- Filled Brown Waterskin
	[7770]={s=0},  -- Filled Blue Waterskin
	[7771]={s=0},  -- Filled Red Waterskin
	[7786]={s=5605},  -- Headsplitter
	[7787]={s=3960},  -- Resplendent Guardian
	[7806]={s=10},  -- Lollipop
	[7807]={s=10},  -- Candy Bar
	[7808]={s=10},  -- Chocolate Square
	[7809]={s=1024},  -- Easter Dress
	[7810]={s=0},  -- Vial of Purest Water
	[7811]={s=0},  -- Remaining Drops of Purest Water
	[7812]={s=0},  -- Corrupt Manifestation's Bracers
	[7813]={s=0},  -- Shard of Water
	[7846]={s=0},  -- Crag Coyote Fang
	[7847]={s=0},  -- Buzzard Gizzard
	[7848]={s=0},  -- Rock Elemental Shard
	[7866]={s=0},  -- Empty Thaumaturgy Vessel
	[7867]={s=0},  -- Vessel of Dragon's Blood
	[7870]={s=0},  -- Thaumaturgy Vessel Lockbox
	[7871]={s=0},  -- Token of Thievery
	[7886]={s=0},  -- Untranslated Journal
	[7887]={s=0},  -- Necklace and Gem Salvage
	[7888]={s=8990},  -- Jarkal's Enhancing Necklace
	[7906]={s=0},  -- Horns of Nez'ra
	[7907]={s=0},  -- Certificate of Thievery
	[7908]={s=0},  -- Klaven Mortwake's Journal
	[7909]={s=1000},  -- Aquamarine
	[7910]={s=5000},  -- Star Ruby
	[7911]={s=500},  -- Truesilver Ore
	[7912]={s=100},  -- Solid Stone
	[7913]={s=2500},  -- Barbaric Iron Shoulders
	[7914]={s=3330},  -- Barbaric Iron Breastplate
	[7915]={s=3337},  -- Barbaric Iron Helm
	[7916]={s=3700},  -- Barbaric Iron Boots
	[7917]={s=2711},  -- Barbaric Iron Gloves
	[7918]={s=3701},  -- Heavy Mithril Shoulder
	[7919]={s=2476},  -- Heavy Mithril Gauntlet
	[7920]={s=8053},  -- Mithril Scale Pants
	[7921]={s=5387},  -- Heavy Mithril Pants
	[7922]={s=2377},  -- Steel Plate Helm
	[7923]={s=0},  -- Defias Tower Key
	[7924]={s=4103},  -- Mithril Scale Bracers
	[7926]={s=5952},  -- Ornate Mithril Pants
	[7927]={s=2987},  -- Ornate Mithril Gloves
	[7928]={s=4857},  -- Ornate Mithril Shoulder
	[7929]={s=7739},  -- Orcish War Leggings
	[7930]={s=7045},  -- Heavy Mithril Breastplate
	[7931]={s=7955},  -- Mithril Coif
	[7932]={s=8661},  -- Mithril Scale Shoulders
	[7933]={s=5769},  -- Heavy Mithril Boots
	[7934]={s=5790},  -- Heavy Mithril Helm
	[7935]={s=8368},  -- Ornate Mithril Breastplate
	[7936]={s=6739},  -- Ornate Mithril Boots
	[7937]={s=6763},  -- Ornate Mithril Helm
	[7938]={s=4028},  -- Truesilver Gauntlets
	[7939]={s=10899},  -- Truesilver Breastplate
	[7941]={s=12520},  -- Heavy Mithril Axe
	[7942]={s=14659},  -- Blue Glittering Axe
	[7943]={s=15891},  -- Wicked Mithril Blade
	[7944]={s=20092},  -- Dazzling Mithril Rapier
	[7945]={s=17291},  -- Big Black Mace
	[7946]={s=21660},  -- Runed Mithril Hammer
	[7947]={s=24892},  -- Ebon Shiv
	[7954]={s=23159},  -- The Shatterer
	[7955]={s=241},  -- Copper Claymore
	[7956]={s=1944},  -- Bronze Warhammer
	[7957]={s=2205},  -- Bronze Greatsword
	[7958]={s=2435},  -- Bronze Battle Axe
	[7959]={s=33857},  -- Blight
	[7960]={s=38548},  -- Truesilver Champion
	[7961]={s=25508},  -- Phantom Blade
	[7963]={s=6488},  -- Steel Breastplate
	[7964]={s=40},  -- Solid Sharpening Stone
	[7965]={s=40},  -- Solid Weightstone
	[7966]={s=200},  -- Solid Grinding Stone
	[7967]={s=250},  -- Mithril Shield Spike
	[7968]={s=0},  -- Southsea Treasure
	[7969]={s=250},  -- Mithril Spurs
	[7970]={s=0},  -- E.C.A.C.
	[7971]={s=1000},  -- Black Pearl
	[7972]={s=400},  -- Ichor of Undeath
	[7973]={s=46},  -- Big-mouth Clam
	[7974]={s=50},  -- Zesty Clam Meat
	[7975]={s=1500},  -- Plans: Heavy Mithril Pants
	[7976]={s=2000},  -- Plans: Mithril Shield Spike
	[7978]={s=750},  -- Plans: Barbaric Iron Shoulders
	[7979]={s=750},  -- Plans: Barbaric Iron Breastplate
	[7980]={s=850},  -- Plans: Barbaric Iron Helm
	[7981]={s=1100},  -- Plans: Barbaric Iron Boots
	[7982]={s=1100},  -- Plans: Barbaric Iron Gloves
	[7983]={s=2000},  -- Plans: Ornate Mithril Pants
	[7984]={s=2000},  -- Plans: Ornate Mithril Gloves
	[7985]={s=2000},  -- Plans: Ornate Mithril Shoulder
	[7989]={s=2500},  -- Plans: Mithril Spurs
	[7990]={s=2500},  -- Plans: Heavy Mithril Helm
	[7991]={s=2500},  -- Plans: Mithril Scale Shoulders
	[7992]={s=2000},  -- Plans: Blue Glittering Axe
	[7993]={s=2500},  -- Plans: Dazzling Mithril Rapier
	[7995]={s=1500},  -- Plans: Mithril Scale Bracers
	[7997]={s=81},  -- Red Defias Mask
	[8006]={s=12472},  -- The Ziggler
	[8007]={s=0},  -- Mana Citrine
	[8008]={s=0},  -- Mana Ruby
	[8009]={s=0},  -- Dentrium Power Stone
	[8026]={s=0},  -- Garrett Family Treasure
	[8027]={s=0},  -- Krom Stoutarm's Treasure
	[8028]={s=2500},  -- Plans: Runed Mithril Hammer
	[8029]={s=2000},  -- Plans: Wicked Mithril Blade
	[8030]={s=2500},  -- Plans: Ebon Shiv
	[8046]={s=0},  -- Kearnen's Journal
	[8047]={s=0},  -- Magenta Fungus Cap
	[8048]={s=0},  -- Emerald Dreamcatcher
	[8049]={s=0},  -- Gnarlpine Necklace
	[8050]={s=0},  -- Tallonkai's Jewel
	[8051]={s=0},  -- Flare Gun
	[8052]={s=0},  -- An'Alleum Power Stone
	[8053]={s=0},  -- Obsidian Power Source
	[8066]={s=0},  -- Fizzule's Whistle
	[8067]={s=0},  -- Crafted Light Shot
	[8068]={s=0},  -- Crafted Heavy Shot
	[8069]={s=0},  -- Crafted Solid Shot
	[8070]={s=0},  -- Reward Voucher
	[8071]={s=1534},  -- Sizzle Stick
	[8072]={s=0},  -- Silixiz's Tower Key
	[8073]={s=0},  -- Cache of Zanzil's Altered Mixture
	[8074]={s=0},  -- Gallywix's Head
	[8075]={s=0},  -- Conjured Sourdough
	[8076]={s=0},  -- Conjured Sweet Roll
	[8077]={s=0},  -- Conjured Mineral Water
	[8078]={s=0},  -- Conjured Sparkling Water
	[8079]={s=0},  -- Conjured Crystal Water
	[8080]={s=5987},  -- Light Plate Chestpiece
	[8081]={s=2834},  -- Light Plate Belt
	[8082]={s=3189},  -- Light Plate Boots
	[8083]={s=2261},  -- Light Plate Bracers
	[8084]={s=2703},  -- Light Plate Gloves
	[8085]={s=5253},  -- Light Plate Pants
	[8086]={s=3730},  -- Light Plate Shoulderpads
	[8087]={s=0},  -- Sample of Zanzil's Altered Mixture
	[8088]={s=2667},  -- Platemail Belt
	[8089]={s=4016},  -- Platemail Boots
	[8090]={s=2687},  -- Platemail Bracers
	[8091]={s=2697},  -- Platemail Gloves
	[8092]={s=4062},  -- Platemail Helm
	[8093]={s=5437},  -- Platemail Leggings
	[8094]={s=5458},  -- Platemail Armor
	[8095]={s=0},  -- Hinott's Oil
	[8106]={s=10438},  -- Hibernal Armor
	[8107]={s=5938},  -- Hibernal Boots
	[8108]={s=3594},  -- Hibernal Bracers
	[8109]={s=5011},  -- Hibernal Cloak
	[8110]={s=3622},  -- Hibernal Gloves
	[8111]={s=5890},  -- Hibernal Mantle
	[8112]={s=8436},  -- Hibernal Pants
	[8113]={s=9694},  -- Hibernal Robe
	[8114]={s=3677},  -- Hibernal Sash
	[8115]={s=5980},  -- Hibernal Cowl
	[8116]={s=4632},  -- Heraldic Belt
	[8117]={s=7161},  -- Heraldic Boots
	[8118]={s=4436},  -- Heraldic Bracers
	[8119]={s=12725},  -- Heraldic Breastplate
	[8120]={s=6207},  -- Heraldic Cloak
	[8121]={s=4843},  -- Heraldic Gloves
	[8122]={s=7875},  -- Heraldic Headpiece
	[8123]={s=11275},  -- Heraldic Leggings
	[8124]={s=7932},  -- Heraldic Spaulders
	[8125]={s=6367},  -- Myrmidon's Bracers
	[8126]={s=15656},  -- Myrmidon's Breastplate
	[8127]={s=5937},  -- Myrmidon's Cape
	[8128]={s=6229},  -- Myrmidon's Gauntlets
	[8129]={s=6253},  -- Myrmidon's Girdle
	[8130]={s=9458},  -- Myrmidon's Greaves
	[8131]={s=10115},  -- Myrmidon's Helm
	[8132]={s=14485},  -- Myrmidon's Leggings
	[8133]={s=10517},  -- Myrmidon's Pauldrons
	[8134]={s=15993},  -- Myrmidon's Defender
	[8135]={s=11234},  -- Chromite Shield
	[8136]={s=0},  -- Gargantuan Tumor
	[8137]={s=2807},  -- Chromite Bracers
	[8138]={s=7666},  -- Chromite Chestplate
	[8139]={s=3053},  -- Chromite Gauntlets
	[8140]={s=2837},  -- Chromite Girdle
	[8141]={s=4613},  -- Chromite Greaves
	[8142]={s=4630},  -- Chromite Barbute
	[8143]={s=7227},  -- Chromite Legplates
	[8144]={s=5036},  -- Chromite Pauldrons
	[8146]={s=500},  -- Wicked Claw
	[8149]={s=0},  -- Voodoo Charm
	[8150]={s=250},  -- Deeprock Salt
	[8151]={s=250},  -- Flask of Mojo
	[8152]={s=500},  -- Flask of Big Mojo
	[8153]={s=5},  -- Wildvine
	[8154]={s=250},  -- Scorpid Scale
	[8155]={s=0},  -- Sathrah's Sacrifice
	[8156]={s=2219},  -- Jouster's Wristguards
	[8157]={s=5197},  -- Jouster's Chestplate
	[8158]={s=2236},  -- Jouster's Gauntlets
	[8159]={s=2244},  -- Jouster's Girdle
	[8160]={s=3378},  -- Jouster's Greaves
	[8161]={s=3390},  -- Jouster's Visor
	[8162]={s=4900},  -- Jouster's Legplates
	[8163]={s=3688},  -- Jouster's Pauldrons
	[8164]={s=2},  -- Test Stationery
	[8165]={s=500},  -- Worn Dragonscale
	[8167]={s=100},  -- Turtle Scale
	[8168]={s=100},  -- Jet Black Feather
	[8169]={s=500},  -- Thick Hide
	[8170]={s=500},  -- Rugged Leather
	[8171]={s=500},  -- Rugged Hide
	[8172]={s=500},  -- Cured Thick Hide
	[8173]={s=1000},  -- Thick Armor Kit
	[8174]={s=4131},  -- Comfortable Leather Hat
	[8175]={s=5971},  -- Nightscape Tunic
	[8176]={s=4495},  -- Nightscape Headband
	[8177]={s=71},  -- Practice Sword
	[8178]={s=306},  -- Training Sword
	[8179]={s=28},  -- Cadet's Bow
	[8180]={s=240},  -- Hunting Bow
	[8181]={s=79},  -- Hunting Rifle
	[8182]={s=40},  -- Pellet Rifle
	[8183]={s=2426},  -- Precision Bow
	[8184]={s=2947},  -- Firestarter
	[8185]={s=10952},  -- Turtle Scale Leggings
	[8186]={s=2231},  -- Dire Wand
	[8187]={s=3477},  -- Turtle Scale Gloves
	[8188]={s=6414},  -- Explosive Shotgun
	[8189]={s=7567},  -- Turtle Scale Breastplate
	[8190]={s=37286},  -- Hanzo Sword
	[8191]={s=7780},  -- Turtle Scale Helm
	[8192]={s=4782},  -- Nightscape Shoulders
	[8193]={s=8708},  -- Nightscape Pants
	[8194]={s=13877},  -- Goblin Nutcracker
	[8196]={s=13979},  -- Ebon Scimitar
	[8197]={s=7158},  -- Nightscape Boots
	[8198]={s=4013},  -- Turtle Scale Bracers
	[8199]={s=24661},  -- Battlefield Destroyer
	[8200]={s=7275},  -- Big Voodoo Robe
	[8201]={s=5350},  -- Big Voodoo Mask
	[8202]={s=9022},  -- Big Voodoo Pants
	[8203]={s=8628},  -- Tough Scorpid Breastplate
	[8204]={s=4676},  -- Tough Scorpid Gloves
	[8205]={s=4346},  -- Tough Scorpid Bracers
	[8206]={s=12704},  -- Tough Scorpid Leggings
	[8207]={s=8978},  -- Tough Scorpid Shoulders
	[8208]={s=10272},  -- Tough Scorpid Helm
	[8209]={s=8375},  -- Tough Scorpid Boots
	[8210]={s=5537},  -- Wild Leather Shoulders
	[8211]={s=8002},  -- Wild Leather Vest
	[8212]={s=11585},  -- Wild Leather Leggings
	[8213]={s=8150},  -- Wild Leather Boots
	[8214]={s=6230},  -- Wild Leather Helmet
	[8215]={s=9017},  -- Wild Leather Cloak
	[8216]={s=6323},  -- Big Voodoo Cloak
	[8217]={s=1000},  -- Quickdraw Quiver
	[8218]={s=1000},  -- Thick Leather Ammo Pouch
	[8223]={s=10066},  -- Blade of the Basilisk
	[8224]={s=7655},  -- Silithid Ripper
	[8225]={s=9222},  -- Tainted Pierce
	[8226]={s=5747},  -- The Butcher
	[8244]={s=10000},  -- Flawless Draenethyst Sphere
	[8245]={s=12922},  -- Imperial Red Tunic
	[8246]={s=7917},  -- Imperial Red Boots
	[8247]={s=4997},  -- Imperial Red Bracers
	[8248]={s=7032},  -- Imperial Red Cloak
	[8249]={s=5336},  -- Imperial Red Gloves
	[8250]={s=8034},  -- Imperial Red Mantle
	[8251]={s=12080},  -- Imperial Red Pants
	[8252]={s=13622},  -- Imperial Red Robe
	[8253]={s=5107},  -- Imperial Red Sash
	[8254]={s=8639},  -- Imperial Red Circlet
	[8255]={s=6010},  -- Serpentskin Girdle
	[8256]={s=10261},  -- Serpentskin Boots
	[8257]={s=6053},  -- Serpentskin Bracers
	[8258]={s=17396},  -- Serpentskin Armor
	[8259]={s=9144},  -- Serpentskin Cloak
	[8260]={s=6938},  -- Serpentskin Gloves
	[8261]={s=10617},  -- Serpentskin Helm
	[8262]={s=14605},  -- Serpentskin Leggings
	[8263]={s=10373},  -- Serpentskin Spaulders
	[8264]={s=7857},  -- Ebonhold Wristguards
	[8265]={s=19914},  -- Ebonhold Armor
	[8266]={s=7468},  -- Ebonhold Cloak
	[8267]={s=8927},  -- Ebonhold Gauntlets
	[8268]={s=8960},  -- Ebonhold Girdle
	[8269]={s=14362},  -- Ebonhold Boots
	[8270]={s=14351},  -- Ebonhold Helmet
	[8271]={s=20358},  -- Ebonhold Leggings
	[8272]={s=13697},  -- Ebonhold Shoulderpads
	[8273]={s=3574},  -- Valorous Wristguards
	[8274]={s=10251},  -- Valorous Chestguard
	[8275]={s=22028},  -- Ebonhold Buckler
	[8276]={s=3901},  -- Valorous Gauntlets
	[8277]={s=3625},  -- Valorous Girdle
	[8278]={s=5477},  -- Valorous Greaves
	[8279]={s=5937},  -- Valorous Helm
	[8280]={s=8503},  -- Valorous Legguards
	[8281]={s=5982},  -- Valorous Pauldrons
	[8282]={s=15695},  -- Valorous Shield
	[8283]={s=17138},  -- Arcane Armor
	[8284]={s=10514},  -- Arcane Boots
	[8285]={s=6637},  -- Arcane Bands
	[8286]={s=9427},  -- Arcane Cloak
	[8287]={s=7087},  -- Arcane Gloves
	[8288]={s=11876},  -- Arcane Pads
	[8289]={s=16688},  -- Arcane Leggings
	[8290]={s=17585},  -- Arcane Robe
	[8291]={s=6784},  -- Arcane Sash
	[8292]={s=11476},  -- Arcane Cover
	[8293]={s=8542},  -- Traveler's Belt
	[8294]={s=12651},  -- Traveler's Boots
	[8295]={s=7988},  -- Traveler's Bracers
	[8296]={s=20861},  -- Traveler's Jerkin
	[8297]={s=9113},  -- Traveler's Cloak
	[8298]={s=8565},  -- Traveler's Gloves
	[8299]={s=14353},  -- Traveler's Helm
	[8300]={s=20172},  -- Traveler's Leggings
	[8301]={s=14463},  -- Traveler's Spaulders
	[8302]={s=11060},  -- Hero's Bracers
	[8303]={s=26989},  -- Hero's Breastplate
	[8304]={s=10513},  -- Hero's Cape
	[8305]={s=11743},  -- Hero's Gauntlets
	[8306]={s=11787},  -- Hero's Belt
	[8307]={s=18717},  -- Hero's Boots
	[8308]={s=18703},  -- Hero's Band
	[8309]={s=26278},  -- Hero's Leggings
	[8310]={s=19419},  -- Hero's Pauldrons
	[8311]={s=5844},  -- Alabaster Plate Vambraces
	[8312]={s=14810},  -- Alabaster Breastplate
	[8313]={s=30637},  -- Hero's Buckler
	[8314]={s=5344},  -- Alabaster Plate Gauntlets
	[8315]={s=5061},  -- Alabaster Plate Girdle
	[8316]={s=8078},  -- Alabaster Plate Greaves
	[8317]={s=8595},  -- Alabaster Plate Helmet
	[8318]={s=12926},  -- Alabaster Plate Leggings
	[8319]={s=9181},  -- Alabaster Plate Pauldrons
	[8320]={s=22092},  -- Alabaster Shield
	[8343]={s=500},  -- Heavy Silken Thread
	[8344]={s=0},  -- Silvery Spinnerets
	[8345]={s=7421},  -- Wolfshead Helm
	[8346]={s=5363},  -- Gauntlets of the Sea
	[8347]={s=5979},  -- Dragonscale Gauntlets
	[8348]={s=10819},  -- Helm of Fire
	[8349]={s=14478},  -- Feathered Breastplate
	[8350]={s=1130},  -- The 1 Ring
	[8363]={s=0},  -- Shaman Voodoo Charm
	[8364]={s=6},  -- Mithril Head Trout
	[8365]={s=4},  -- Raw Mithril Head Trout
	[8367]={s=18455},  -- Dragonscale Breastplate
	[8368]={s=1000},  -- Thick Wolfhide
	[8383]={s=0},  -- Plain Letter
	[8384]={s=875},  -- Pattern: Comfortable Leather Hat
	[8385]={s=875},  -- Pattern: Turtle Scale Gloves
	[8386]={s=1000},  -- Pattern: Big Voodoo Robe
	[8387]={s=1000},  -- Pattern: Big Voodoo Mask
	[8389]={s=1250},  -- Pattern: Big Voodoo Pants
	[8390]={s=1250},  -- Pattern: Big Voodoo Cloak
	[8391]={s=0},  -- Snickerfang Jowl
	[8392]={s=0},  -- Blasted Boar Lung
	[8393]={s=0},  -- Scorpok Pincer
	[8394]={s=0},  -- Basilisk Brain
	[8395]={s=1000},  -- Pattern: Tough Scorpid Breastplate
	[8396]={s=0},  -- Vulture Gizzard
	[8397]={s=1000},  -- Pattern: Tough Scorpid Bracers
	[8398]={s=1125},  -- Pattern: Tough Scorpid Gloves
	[8399]={s=1250},  -- Pattern: Tough Scorpid Boots
	[8400]={s=1250},  -- Pattern: Tough Scorpid Shoulders
	[8401]={s=1375},  -- Pattern: Tough Scorpid Leggings
	[8402]={s=1375},  -- Pattern: Tough Scorpid Helm
	[8403]={s=1000},  -- Pattern: Wild Leather Shoulders
	[8404]={s=1000},  -- Pattern: Wild Leather Vest
	[8405]={s=1000},  -- Pattern: Wild Leather Helmet
	[8406]={s=1250},  -- Pattern: Wild Leather Boots
	[8407]={s=1250},  -- Pattern: Wild Leather Leggings
	[8408]={s=1250},  -- Pattern: Wild Leather Cloak
	[8409]={s=1000},  -- Pattern: Nightscape Shoulders
	[8410]={s=0},  -- R.O.I.D.S.
	[8411]={s=0},  -- Lung Juice Cocktail
	[8412]={s=0},  -- Ground Scorpok Assay
	[8423]={s=0},  -- Cerebral Cortex Compound
	[8424]={s=0},  -- Gizzard Gum
	[8425]={s=0},  -- Parrot Droppings
	[8426]={s=0},  -- Large Ruffled Feather
	[8427]={s=0},  -- Mutilated Rat Carcass
	[8428]={s=0},  -- Laden Dew Gland
	[8429]={s=31},  -- Punctured Dew Gland
	[8430]={s=46},  -- Empty Dew Gland
	[8431]={s=0},  -- Spool of Light Chartreuse Silk Thread
	[8432]={s=0},  -- Eau de Mixilpixil
	[8443]={s=0},  -- Gahz'ridian Ornament
	[8444]={s=0},  -- Executioner's Key
	[8463]={s=0},  -- Warchief's Orders
	[8483]={s=171},  -- Wastewander Water Pouch
	[8484]={s=68},  -- Gadgetzan Water Co. Care Package
	[8485]={s=1000},  -- Cat Carrier (Bombay)
	[8486]={s=1000},  -- Cat Carrier (Cornish Rex)
	[8487]={s=1000},  -- Cat Carrier (Orange Tabby)
	[8488]={s=1000},  -- Cat Carrier (Silver Tabby)
	[8489]={s=1500},  -- Cat Carrier (White Kitten)
	[8490]={s=1500},  -- Cat Carrier (Siamese)
	[8491]={s=1500},  -- Cat Carrier (Maine Coon)
	[8492]={s=1000},  -- Parrot Cage (Green Wing Macaw)
	[8494]={s=1000},  -- Parrot Cage (Hyacinth Macaw)
	[8495]={s=1000},  -- Parrot Cage (Senegal)
	[8496]={s=1000},  -- Parrot Cage (Cockatiel)
	[8497]={s=500},  -- Rabbit Crate (Snowshoe)
	[8498]={s=2500},  -- Tiny Emerald Whelpling
	[8499]={s=2500},  -- Tiny Crimson Whelpling
	[8500]={s=1250},  -- Great Horned Owl
	[8501]={s=1250},  -- Hawk Owl
	[8523]={s=0},  -- Field Testing Kit
	[8524]={s=0},  -- Model 4711-FTZ Power Source
	[8525]={s=0},  -- Zinge's Purchase Order
	[8526]={s=0},  -- Violet Tragan
	[8527]={s=0},  -- Sealed Field Testing Kit
	[8528]={s=0},  -- Violet Powder
	[8529]={s=175},  -- Noggenfogger Elixir
	[8544]={s=400},  -- Mageweave Bandage
	[8545]={s=600},  -- Heavy Mageweave Bandage
	[8548]={s=0},  -- Divino-matic Rod
	[8563]={s=0},  -- Red Mechanostrider
	[8564]={s=200},  -- Hippogryph Egg
	[8584]={s=0},  -- Untapped Dowsing Widget
	[8585]={s=0},  -- Tapped Dowsing Widget
	[8586]={s=0},  -- Whistle of the Mottled Red Raptor
	[8587]={s=0},  -- Centipaar Insect Parts
	[8588]={s=0},  -- Whistle of the Emerald Raptor
	[8591]={s=0},  -- Whistle of the Turquoise Raptor
	[8592]={s=0},  -- Whistle of the Violet Raptor
	[8593]={s=0},  -- Scrimshank's Surveying Gear
	[8594]={s=0},  -- Insect Analysis Report
	[8595]={s=0},  -- Blue Mechanostrider
	[8603]={s=0},  -- Thistleshrub Dew
	[8623]={s=0},  -- OOX-17/TN Distress Beacon
	[8626]={s=250},  -- Blue Sparkler
	[8629]={s=0},  -- Reins of the Striped Nightsaber
	[8631]={s=0},  -- Reins of the Striped Frostsaber
	[8632]={s=0},  -- Reins of the Spotted Frostsaber
	[8643]={s=2500},  -- Extraordinary Egg
	[8644]={s=1500},  -- Fine Egg
	[8645]={s=750},  -- Ordinary Egg
	[8646]={s=250},  -- Bad Egg
	[8647]={s=0},  -- Egg Crate
	[8663]={s=0},  -- Mithril Insignia
	[8683]={s=1},  -- Clara's Fresh Apple
	[8684]={s=0},  -- Hinterlands Honey Ripple
	[8685]={s=0},  -- Dran's Ripple Delivery
	[8686]={s=0},  -- Mithril Pendant
	[8687]={s=0},  -- Sealed Description of Thredd's Visitor
	[8703]={s=6492},  -- Signet of Expertise
	[8704]={s=0},  -- OOX-09/HL Distress Beacon
	[8705]={s=0},  -- OOX-22/FE Distress Beacon
	[8707]={s=0},  -- Gahz'rilla's Electrified Scale
	[8708]={s=0},  -- Hammer of Expertise
	[8723]={s=0},  -- Caliph Scorpidsting's Head
	[8724]={s=0},  -- Rin'ji's Secret
	[8746]={s=682},  -- Interlaced Cowl
	[8747]={s=1036},  -- Hardened Leather Helm
	[8748]={s=774},  -- Double Mail Coif
	[8749]={s=1603},  -- Crochet Hat
	[8750]={s=1863},  -- Thick Leather Hat
	[8751]={s=2618},  -- Overlinked Coif
	[8752]={s=5217},  -- Laminated Scale Circlet
	[8753]={s=5198},  -- Smooth Leather Helmet
	[8754]={s=3937},  -- Twill Cover
	[8755]={s=3728},  -- Light Plate Helmet
	[8766]={s=200},  -- Morning Glory Dew
	[8831]={s=300},  -- Purple Lotus
	[8836]={s=95},  -- Arthas' Tears
	[8838]={s=60},  -- Sungrass
	[8839]={s=375},  -- Blindweed
	[8845]={s=375},  -- Ghost Mushroom
	[8846]={s=250},  -- Gromsblood
	[8923]={s=50},  -- Essence of Agony
	[8924]={s=25},  -- Dust of Deterioration
	[8925]={s=125},  -- Crystal Vial
	[8926]={s=75},  -- Instant Poison IV
	[8927]={s=100},  -- Instant Poison V
	[8928]={s=125},  -- Instant Poison VI
	[8932]={s=200},  -- Alterac Swiss
	[8948]={s=200},  -- Dried King Bolete
	[8949]={s=200},  -- Elixir of Agility
	[8950]={s=200},  -- Homemade Cherry Pie
	[8951]={s=200},  -- Elixir of Greater Defense
	[8952]={s=200},  -- Roasted Quail
	[8953]={s=200},  -- Deep Fried Plantains
	[8956]={s=200},  -- Oil of Immolation
	[8957]={s=200},  -- Spinefin Halibut
	[8959]={s=160},  -- Raw Spinefin Halibut
	[8973]={s=0},  -- Thick Yeti Hide
	[8984]={s=100},  -- Deadly Poison III
	[8985]={s=150},  -- Deadly Poison IV
	[9030]={s=200},  -- Restorative Elixir
	[9036]={s=20},  -- Magic Resistance Potion
	[9060]={s=1000},  -- Inlaid Mithril Cylinder
	[9061]={s=250},  -- Goblin Rocket Fuel
	[9088]={s=250},  -- Gift of Arthas
	[9144]={s=250},  -- Wildvine Potion
	[9149]={s=250},  -- Philosophers' Stone
	[9153]={s=0},  -- Rig Blueprints
	[9154]={s=300},  -- Elixir of Detect Undead
	[9155]={s=400},  -- Arcane Elixir
	[9172]={s=500},  -- Invisibility Potion
	[9173]={s=0},  -- Goblin Transponder
	[9179]={s=1000},  -- Elixir of Greater Intellect
	[9186]={s=175},  -- Mind-numbing Poison III
	[9187]={s=600},  -- Elixir of Greater Agility
	[9189]={s=0},  -- Shay's Bell
	[9197]={s=600},  -- Elixir of Dream Vision
	[9206]={s=700},  -- Elixir of Giants
	[9210]={s=750},  -- Ghost Dye
	[9214]={s=2500},  -- Grimoire of Inferno
	[9224]={s=700},  -- Elixir of Demonslaying
	[9233]={s=500},  -- Elixir of Detect Demon
	[9234]={s=0},  -- Tiara of the Deep
	[9235]={s=0},  -- Pratt's Letter
	[9236]={s=0},  -- Jangdor's Letter
	[9237]={s=0},  -- Woodpaw Gnoll Mane
	[9238]={s=0},  -- Uncracked Scarab Shell
	[9240]={s=0},  -- Mallet of Zul'Farrak
	[9241]={s=0},  -- Sacred Mallet
	[9242]={s=2421},  -- Ancient Tablet
	[9243]={s=0},  -- Shriveled Heart
	[9244]={s=0},  -- Stoley's Shipment
	[9245]={s=0},  -- Stoley's Bottle
	[9246]={s=0},  -- Firebeard's Head
	[9247]={s=0},  -- Hatecrest Naga Scale
	[9248]={s=0},  -- Mysterious Relic
	[9249]={s=1553},  -- Captain's Key
	[9250]={s=0},  -- Ship Schedule
	[9251]={s=62},  -- Upper Map Fragment
	[9252]={s=62},  -- Lower Map Fragment
	[9253]={s=62},  -- Middle Map Fragment
	[9254]={s=0},  -- Cuergo's Treasure Map
	[9255]={s=0},  -- Lahassa Essence
	[9256]={s=0},  -- Imbel Essence
	[9257]={s=0},  -- Samha Essence
	[9258]={s=0},  -- Byltan Essence
	[9259]={s=64},  -- Troll Tribal Necklace
	[9260]={s=400},  -- Volatile Rum
	[9261]={s=250},  -- Lead Ore
	[9262]={s=1000},  -- Black Vitriol
	[9263]={s=0},  -- Troyas' Stave
	[9264]={s=35},  -- Elixir of Shadow Power
	[9265]={s=15},  -- Cuergo's Hidden Treasure
	[9266]={s=0},  -- Woodpaw Battle Plans
	[9275]={s=0},  -- Cuergo's Key
	[9276]={s=100},  -- Pirate's Footlocker
	[9277]={s=0},  -- Techbot's Memory Core
	[9278]={s=0},  -- Essential Artificial
	[9279]={s=45},  -- White Punch Card
	[9280]={s=0},  -- Yellow Punch Card
	[9281]={s=0},  -- Red Punch Card
	[9282]={s=0},  -- Blue Punch Card
	[9283]={s=0},  -- Empty Leaden Collection Phial
	[9284]={s=0},  -- Full Leaden Collection Phial
	[9285]={s=2388},  -- Field Plate Vambraces
	[9286]={s=6040},  -- Field Plate Armor
	[9287]={s=2406},  -- Field Plate Gauntlets
	[9288]={s=2414},  -- Field Plate Girdle
	[9289]={s=3635},  -- Field Plate Boots
	[9290]={s=3940},  -- Field Plate Helmet
	[9291]={s=5286},  -- Field Plate Leggings
	[9292]={s=3684},  -- Field Plate Pauldrons
	[9293]={s=1250},  -- Recipe: Magic Resistance Potion
	[9294]={s=2000},  -- Recipe: Wildvine Potion
	[9295]={s=2000},  -- Recipe: Invisibility Potion
	[9296]={s=2000},  -- Recipe: Gift of Arthas
	[9297]={s=2500},  -- Recipe: Elixir of Dream Vision
	[9298]={s=2250},  -- Recipe: Elixir of Giants
	[9299]={s=0},  -- Thermaplugg's Safe Combination
	[9300]={s=2500},  -- Recipe: Elixir of Demonslaying
	[9301]={s=2500},  -- Recipe: Elixir of Shadow Power
	[9302]={s=2250},  -- Recipe: Ghost Dye
	[9303]={s=2000},  -- Recipe: Philosophers' Stone
	[9304]={s=2000},  -- Recipe: Transmute Iron to Gold
	[9305]={s=2000},  -- Recipe: Transmute Mithril to Truesilver
	[9306]={s=0},  -- Stave of Equinex
	[9307]={s=0},  -- A Sparkling Stone
	[9308]={s=38},  -- Grime-Encrusted Object
	[9309]={s=0},  -- Robo-mechanical Guts
	[9311]={s=0},  -- Default Stationery
	[9312]={s=12},  -- Blue Firework
	[9313]={s=12},  -- Green Firework
	[9316]={s=0},  -- Prismatic Punch Card
	[9318]={s=12},  -- Red Firework
	[9319]={s=0},  -- Nimboya's Laden Pike
	[9320]={s=0},  -- Witherbark Skull
	[9321]={s=0},  -- Venom Bottle
	[9322]={s=0},  -- Undamaged Venom Sac
	[9323]={s=0},  -- Gadrin's Parchment
	[9324]={s=0},  -- Shadra's Venom
	[9326]={s=0},  -- Grime-Encrusted Ring
	[9327]={s=625},  -- Security DELTA Data Access Card
	[9328]={s=0},  -- Super Snapper FX
	[9329]={s=0},  -- A Short Note
	[9330]={s=0},  -- Snapshot of Gammerita
	[9331]={s=0},  -- Feralas: A History
	[9332]={s=38},  -- Crusted Bandages
	[9333]={s=73},  -- Tarnished Silver Necklace
	[9334]={s=47},  -- Cracked Pottery
	[9335]={s=52},  -- Broken Obsidian Club
	[9336]={s=1288},  -- Gold-capped Troll Tusk
	[9355]={s=376},  -- Hoop Earring
	[9356]={s=217},  -- A Wooden Leg
	[9357]={s=227},  -- A Parrot Skeleton
	[9358]={s=228},  -- A Head Rag
	[9359]={s=19577},  -- Wirt's Third Leg
	[9360]={s=400},  -- Cuergo's Gold
	[9361]={s=400},  -- Cuergo's Gold with Worm
	[9362]={s=0},  -- Brilliant Gold Ring
	[9363]={s=12},  -- Sparklematic-Wrapped Box
	[9364]={s=0},  -- Heavy Leaden Collection Phial
	[9365]={s=0},  -- High Potency Radioactive Fallout
	[9366]={s=3689},  -- Golden Scale Gauntlets
	[9367]={s=1250},  -- Plans: Golden Scale Gauntlets
	[9368]={s=0},  -- Jer'kai's Signet Ring
	[9369]={s=0},  -- Iridescent Sprite Darter Wing
	[9370]={s=0},  -- Gordunni Scroll
	[9371]={s=0},  -- Gordunni Orb
	[9372]={s=61936},  -- Sul'thraze the Lasher
	[9375]={s=4220},  -- Expert Goldminer's Helmet
	[9378]={s=11380},  -- Shovelphlange's Mining Axe
	[9379]={s=26383},  -- Sang'thraze the Deflector
	[9381]={s=8628},  -- Earthen Rod
	[9382]={s=3607},  -- Tromping Miner's Boots
	[9383]={s=16895},  -- Obsidian Cleaver
	[9384]={s=9789},  -- Stonevault Shiv
	[9385]={s=12280},  -- Archaic Defender
	[9386]={s=9859},  -- Excavator's Brand
	[9387]={s=3438},  -- Revelosh's Boots
	[9388]={s=3196},  -- Revelosh's Armguards
	[9389]={s=4331},  -- Revelosh's Spaulders
	[9390]={s=2146},  -- Revelosh's Gloves
	[9391]={s=12831},  -- The Shoveler
	[9392]={s=12980},  -- Annealed Blade
	[9393]={s=7882},  -- Beacon of Hope
	[9394]={s=4575},  -- Horned Viking Helmet
	[9395]={s=1565},  -- Gloves of Old
	[9396]={s=7319},  -- Legguards of the Vault
	[9397]={s=3672},  -- Energy Cloak
	[9398]={s=2488},  -- Worn Running Boots
	[9399]={s=10},  -- Precision Arrow
	[9400]={s=5414},  -- Baelog's Shortbow
	[9401]={s=16901},  -- Nordic Longshank
	[9402]={s=25308},  -- Earthborn Kilt
	[9403]={s=4436},  -- Battered Viking Shield
	[9404]={s=9398},  -- Olaf's All Purpose Shield
	[9405]={s=2055},  -- Girdle of Golem Strength
	[9406]={s=4161},  -- Spirewind Fetter
	[9407]={s=5094},  -- Stoneweaver Leggings
	[9408]={s=18639},  -- Ironshod Bludgeon
	[9409]={s=4490},  -- Ironaya's Bracers
	[9410]={s=3785},  -- Cragfists
	[9411]={s=7156},  -- Rockshard Pauldrons
	[9412]={s=16681},  -- Galgann's Fireblaster
	[9413]={s=32248},  -- The Rockpounder
	[9414]={s=8645},  -- Oilskin Leggings
	[9415]={s=8997},  -- Grimlok's Tribal Vestments
	[9416]={s=28218},  -- Grimlok's Charge
	[9418]={s=32851},  -- Stoneslayer
	[9419]={s=18076},  -- Galgann's Firehammer
	[9420]={s=4083},  -- Adventurer's Pith Helmet
	[9421]={s=0},  -- Major Healthstone
	[9422]={s=13052},  -- Shadowforge Bushmaster
	[9423]={s=25463},  -- The Jackhammer
	[9424]={s=13594},  -- Ginn-su Sword
	[9425]={s=21489},  -- Pendulum of Doom
	[9426]={s=10275},  -- Monolithic Bow
	[9427]={s=14853},  -- Stonevault Bonebreaker
	[9428]={s=2096},  -- Unearthed Bands
	[9429]={s=5236},  -- Miner's Hat of the Deep
	[9430]={s=8553},  -- Spaulders of a Lost Age
	[9431]={s=4885},  -- Papal Fez
	[9432]={s=3027},  -- Skullplate Bracers
	[9433]={s=4133},  -- Forgotten Wraps
	[9434]={s=5648},  -- Elemental Raiment
	[9435]={s=2916},  -- Reticulated Bone Gauntlets
	[9436]={s=0},  -- Faranell's Parcel
	[9437]={s=0},  -- Untested Basilisk Sample
	[9438]={s=0},  -- Acceptable Scorpid Sample
	[9439]={s=0},  -- Untested Hyena Sample
	[9440]={s=0},  -- Acceptable Basilisk Sample
	[9441]={s=0},  -- Acceptable Hyena Sample
	[9442]={s=0},  -- Untested Scorpid Sample
	[9444]={s=1120},  -- Techbot CPU Shell
	[9445]={s=2260},  -- Grubbis Paws
	[9446]={s=7564},  -- Electrocutioner Leg
	[9447]={s=3237},  -- Electrocutioner Lagnut
	[9448]={s=1154},  -- Spidertank Oilrag
	[9449]={s=9564},  -- Manual Crowd Pummeler
	[9450]={s=2181},  -- Gnomebot Operating Boots
	[9451]={s=25},  -- Bubbling Water
	[9452]={s=8210},  -- Hydrocane
	[9453]={s=6592},  -- Toxic Revenger
	[9454]={s=1984},  -- Acidic Walkers
	[9455]={s=1825},  -- Emissary Cuffs
	[9456]={s=6652},  -- Glass Shooter
	[9457]={s=8902},  -- Royal Diplomatic Scepter
	[9458]={s=6917},  -- Thermaplugg's Central Core
	[9459]={s=13560},  -- Thermaplugg's Left Arm
	[9460]={s=0},  -- Grimtotem Horn
	[9461]={s=4586},  -- Charged Gear
	[9462]={s=0},  -- Crate of Grimtotem Horns
	[9463]={s=0},  -- Gordunni Cobalt
	[9465]={s=18560},  -- Digmaster 5000
	[9466]={s=0},  -- Orwin's Shovel
	[9467]={s=18681},  -- Gahz'rilla Fang
	[9468]={s=0},  -- Sharpbeak's Feather
	[9469]={s=14634},  -- Gahz'rilla Scale Armor
	[9470]={s=7858},  -- Bad Mojo Mask
	[9471]={s=0},  -- Nekrum's Medallion
	[9472]={s=0},  -- Hexx's Key
	[9473]={s=13241},  -- Jinxed Hoodoo Skin
	[9474]={s=13290},  -- Jinxed Hoodoo Kilt
	[9475]={s=33346},  -- Diabolic Skiver
	[9476]={s=8593},  -- Big Bad Pauldrons
	[9477]={s=35936},  -- The Chief's Enforcer
	[9478]={s=28853},  -- Ripsaw
	[9479]={s=10858},  -- Embrace of the Lycan
	[9480]={s=31725},  -- Eyegouger
	[9481]={s=34067},  -- The Minotaur
	[9482]={s=29585},  -- Witch Doctor's Cane
	[9483]={s=19139},  -- Flaming Incinerator
	[9484]={s=10962},  -- Spellshock Leggings
	[9485]={s=5288},  -- Vibroblade
	[9486]={s=5483},  -- Supercharger Battle Axe
	[9487]={s=3632},  -- Hi-tech Supergun
	[9488]={s=4419},  -- Oscillating Power Hammer
	[9489]={s=3690},  -- Gyromatic Icemaker
	[9490]={s=6121},  -- Gizmotron Megachopper
	[9491]={s=1308},  -- Hotshot Pilot's Gloves
	[9492]={s=3172},  -- Electromagnetic Gigaflux Reactivator
	[9507]={s=0},  -- A Carefully-packed Crate
	[9508]={s=2352},  -- Mechbuilder's Overalls
	[9509]={s=2683},  -- Petrolspill Leggings
	[9510]={s=2945},  -- Caverndeep Trudgers
	[9511]={s=21060},  -- Bloodletter Scalpel
	[9512]={s=6341},  -- Blackmetal Cape
	[9513]={s=305},  -- Ley Staff
	[9514]={s=306},  -- Arcane Staff
	[9515]={s=1248},  -- Nether-lace Tunic
	[9516]={s=1285},  -- Astral Knot Blouse
	[9517]={s=13114},  -- Celestial Stave
	[9518]={s=1899},  -- Mud's Crushers
	[9519]={s=2288},  -- Durtfeet Stompers
	[9520]={s=11461},  -- Silent Hunter
	[9521]={s=14382},  -- Skullsplitter
	[9522]={s=4938},  -- Energized Stone Circle
	[9523]={s=0},  -- Troll Temper
	[9527]={s=21613},  -- Spellshifter Rod
	[9528]={s=0},  -- Edana's Dark Heart
	[9530]={s=0},  -- Horn of Hatetalon
	[9531]={s=5264},  -- Gemshale Pauldrons
	[9533]={s=7092},  -- Masons Fraternity Ring
	[9534]={s=8847},  -- Engineer's Guild Headpiece
	[9535]={s=1406},  -- Fire-welded Bracers
	[9536]={s=1411},  -- Fairywing Mantle
	[9538]={s=6463},  -- Talvash's Gold Ring
	[9539]={s=50},  -- Box of Rations
	[9540]={s=150},  -- Box of Spells
	[9541]={s=200},  -- Box of Goodies
	[9542]={s=0},  -- Simple Letter
	[9543]={s=0},  -- Simple Rune
	[9544]={s=0},  -- Simple Memorandum
	[9545]={s=0},  -- Simple Sigil
	[9546]={s=0},  -- Simple Scroll
	[9547]={s=0},  -- Simple Note
	[9548]={s=0},  -- Hallowed Letter
	[9550]={s=0},  -- Encrypted Rune
	[9551]={s=0},  -- Encrypted Sigil
	[9552]={s=0},  -- Rune-Inscribed Note
	[9553]={s=0},  -- Etched Parchment
	[9554]={s=0},  -- Encrypted Tablet
	[9555]={s=0},  -- Encrypted Letter
	[9556]={s=0},  -- Hallowed Rune
	[9557]={s=0},  -- Hallowed Sigil
	[9558]={s=0},  -- Encrypted Memorandum
	[9559]={s=0},  -- Encrypted Scroll
	[9560]={s=0},  -- Encrypted Parchment
	[9561]={s=0},  -- Hallowed Tablet
	[9562]={s=0},  -- Rune-Inscribed Tablet
	[9563]={s=0},  -- Consecrated Rune
	[9564]={s=0},  -- Etched Tablet
	[9565]={s=0},  -- Etched Note
	[9566]={s=0},  -- Etched Rune
	[9567]={s=0},  -- Etched Sigil
	[9568]={s=0},  -- Rune-Inscribed Parchment
	[9569]={s=0},  -- Hallowed Scroll
	[9570]={s=0},  -- Consecrated Letter
	[9571]={s=0},  -- Glyphic Letter
	[9573]={s=0},  -- Glyphic Memorandum
	[9574]={s=0},  -- Glyphic Scroll
	[9575]={s=0},  -- Glyphic Tablet
	[9576]={s=0},  -- Tainted Letter
	[9577]={s=0},  -- Tainted Memorandum
	[9578]={s=0},  -- Tainted Scroll
	[9579]={s=0},  -- Tainted Parchment
	[9580]={s=0},  -- Verdant Sigil
	[9581]={s=0},  -- Verdant Note
	[9587]={s=6250},  -- Thawpelt Sack
	[9588]={s=6463},  -- Nogg's Gold Ring
	[9589]={s=0},  -- Encrusted Minerals
	[9590]={s=0},  -- Splintered Log
	[9591]={s=0},  -- Resilient Sinew
	[9592]={s=0},  -- Metallic Fragments
	[9593]={s=0},  -- Treant Muisek
	[9594]={s=0},  -- Wildkin Muisek
	[9595]={s=0},  -- Hippogryph Muisek
	[9596]={s=0},  -- Faerie Dragon Muisek
	[9597]={s=0},  -- Mountain Giant Muisek
	[9598]={s=94},  -- Sleeping Robes
	[9599]={s=142},  -- Barkmail Leggings
	[9600]={s=93},  -- Lace Pants
	[9601]={s=87},  -- Cushioned Boots
	[9602]={s=300},  -- Brushwood Blade
	[9603]={s=302},  -- Gritroot Staff
	[9604]={s=5632},  -- Mechanic's Pipehammer
	[9605]={s=1356},  -- Repairman's Cape
	[9606]={s=0},  -- Treant Muisek Vessel
	[9607]={s=1762},  -- Bastion of Stormwind
	[9608]={s=5028},  -- Shoni's Disarming Tool
	[9609]={s=1009},  -- Shilly Mitts
	[9618]={s=0},  -- Wildkin Muisek Vessel
	[9619]={s=0},  -- Hippogryph Muisek Vessel
	[9620]={s=0},  -- Faerie Dragon Muisek Vessel
	[9621]={s=0},  -- Mountain Giant Muisek Vessel
	[9622]={s=5665},  -- Reedknot Ring
	[9623]={s=4198},  -- Civinad Robes
	[9624]={s=5267},  -- Triprunner Dungarees
	[9625]={s=6344},  -- Dual Reinforced Leggings
	[9626]={s=16243},  -- Dwarven Charge
	[9627]={s=2542},  -- Explorer's League Lodestar
	[9628]={s=0},  -- Neeru's Herb Pouch
	[9629]={s=0},  -- A Shrunken Head
	[9630]={s=5780},  -- Pratt's Handcrafted Boots
	[9631]={s=3868},  -- Pratt's Handcrafted Gloves
	[9632]={s=3883},  -- Jangdor's Handcrafted Gloves
	[9633]={s=5847},  -- Jangdor's Handcrafted Boots
	[9634]={s=3381},  -- Skilled Handling Gloves
	[9635]={s=4713},  -- Master Apothecary Cape
	[9636]={s=3154},  -- Swashbuckler Sash
	[9637]={s=4749},  -- Shinkicker Boots
	[9638]={s=6875},  -- Chelonian Cuffs
	[9639]={s=24111},  -- The Hand of Antu'sul
	[9640]={s=4840},  -- Vice Grips
	[9641]={s=13041},  -- Lifeblood Amulet
	[9642]={s=2092},  -- Band of the Great Tortoise
	[9643]={s=15988},  -- Optomatic Deflector
	[9644]={s=9885},  -- Thermotastic Egg Timer
	[9645]={s=6768},  -- Gnomish Inventor Boots
	[9646]={s=6791},  -- Gnomish Water Sinking Device
	[9647]={s=7962},  -- Failed Flying Experiment
	[9648]={s=6392},  -- Chainlink Towel
	[9649]={s=13229},  -- Royal Highmark Vestments
	[9650]={s=18016},  -- Honorguard Chestpiece
	[9651]={s=26828},  -- Gryphon Rider's Stormhammer
	[9652]={s=13466},  -- Gryphon Rider's Leggings
	[9653]={s=6745},  -- Speedy Racer Goggles
	[9654]={s=16928},  -- Cairnstone Sliver
	[9655]={s=7092},  -- Seedtime Hoop
	[9656]={s=4251},  -- Granite Grips
	[9657]={s=5333},  -- Vinehedge Cinch
	[9658]={s=4086},  -- Boots of the Maharishi
	[9660]={s=4227},  -- Stargazer Cloak
	[9661]={s=9051},  -- Earthclasp Barrier
	[9662]={s=4258},  -- Rushridge Boots
	[9663]={s=9969},  -- Dawnrider's Chestpiece
	[9664]={s=5002},  -- Sentinel's Guard
	[9665]={s=4826},  -- Wingcrest Gloves
	[9666]={s=7266},  -- Stronghorn Girdle
	[9678]={s=17485},  -- Tok'kar's Murloc Basher
	[9679]={s=17550},  -- Tok'kar's Murloc Chopper
	[9680]={s=14090},  -- Tok'kar's Murloc Shanker
	[9681]={s=50},  -- Grilled King Crawler Legs
	[9682]={s=3831},  -- Leather Chef's Belt
	[9683]={s=29952},  -- Strength of the Treant
	[9684]={s=25729},  -- Force of the Hippogryph
	[9686]={s=25914},  -- Spirit of the Faerie Dragon
	[9687]={s=1554},  -- Grappler's Belt
	[9698]={s=1504},  -- Gloves of Insight
	[9699]={s=1812},  -- Garrison Cloak
	[9703]={s=4272},  -- Scorched Cape
	[9704]={s=3573},  -- Rustler Gloves
	[9705]={s=3586},  -- Tharg's Shoelace
	[9706]={s=9212},  -- Tharg's Disk
	[9718]={s=11421},  -- Reforged Blade of Heroes
	[9719]={s=6250},  -- Broken Blade of Heroes
	[9738]={s=0},  -- Gem of Cobrahn
	[9739]={s=0},  -- Gem of Anacondra
	[9740]={s=0},  -- Gem of Pythas
	[9741]={s=0},  -- Gem of Serpentis
	[9742]={s=49},  -- Simple Cord
	[9743]={s=67},  -- Simple Shoes
	[9744]={s=44},  -- Simple Bands
	[9745]={s=54},  -- Simple Cape
	[9746]={s=56},  -- Simple Gloves
	[9747]={s=227},  -- Simple Britches
	[9748]={s=274},  -- Simple Robe
	[9749]={s=275},  -- Simple Blouse
	[9750]={s=57},  -- Gypsy Sash
	[9751]={s=86},  -- Gypsy Sandals
	[9752]={s=57},  -- Gypsy Bands
	[9753]={s=248},  -- Gypsy Buckler
	[9754]={s=70},  -- Gypsy Cloak
	[9755]={s=73},  -- Gypsy Gloves
	[9756]={s=294},  -- Gypsy Trousers
	[9757]={s=363},  -- Gypsy Tunic
	[9758]={s=72},  -- Cadet Belt
	[9759]={s=138},  -- Cadet Boots
	[9760]={s=73},  -- Cadet Bracers
	[9761]={s=58},  -- Cadet Cloak
	[9762]={s=92},  -- Cadet Gauntlets
	[9763]={s=336},  -- Cadet Leggings
	[9764]={s=300},  -- Cadet Shield
	[9765]={s=406},  -- Cadet Vest
	[9766]={s=361},  -- Greenweave Sash
	[9767]={s=616},  -- Greenweave Sandals
	[9768]={s=317},  -- Greenweave Bracers
	[9769]={s=1637},  -- Greenweave Branch
	[9770]={s=416},  -- Greenweave Cloak
	[9771]={s=532},  -- Greenweave Gloves
	[9772]={s=1328},  -- Greenweave Leggings
	[9773]={s=1369},  -- Greenweave Robe
	[9774]={s=1374},  -- Greenweave Vest
	[9775]={s=315},  -- Bandit Cinch
	[9776]={s=547},  -- Bandit Boots
	[9777]={s=318},  -- Bandit Bracers
	[9778]={s=940},  -- Bandit Buckler
	[9779]={s=334},  -- Bandit Cloak
	[9780]={s=369},  -- Bandit Gloves
	[9781]={s=982},  -- Bandit Pants
	[9782]={s=1113},  -- Bandit Jerkin
	[9783]={s=811},  -- Raider's Chestpiece
	[9784]={s=533},  -- Raider's Boots
	[9785]={s=268},  -- Raider's Bracers
	[9786]={s=234},  -- Raider's Cloak
	[9787]={s=358},  -- Raider's Gauntlets
	[9788]={s=312},  -- Raider's Belt
	[9789]={s=741},  -- Raider's Legguards
	[9790]={s=794},  -- Raider's Shield
	[9791]={s=1644},  -- Ivycloth Tunic
	[9792]={s=823},  -- Ivycloth Boots
	[9793]={s=550},  -- Ivycloth Bracelets
	[9794]={s=829},  -- Ivycloth Cloak
	[9795]={s=626},  -- Ivycloth Gloves
	[9796]={s=1038},  -- Ivycloth Mantle
	[9797]={s=1528},  -- Ivycloth Pants
	[9798]={s=1686},  -- Ivycloth Robe
	[9799]={s=635},  -- Ivycloth Sash
	[9800]={s=2027},  -- Ivy Orb
	[9801]={s=708},  -- Superior Belt
	[9802]={s=1204},  -- Superior Boots
	[9803]={s=729},  -- Superior Bracers
	[9804]={s=1874},  -- Superior Buckler
	[9805]={s=709},  -- Superior Cloak
	[9806]={s=833},  -- Superior Gloves
	[9807]={s=1255},  -- Superior Shoulders
	[9808]={s=1848},  -- Superior Leggings
	[9809]={s=1855},  -- Superior Tunic
	[9810]={s=1231},  -- Fortified Boots
	[9811]={s=725},  -- Fortified Bracers
	[9812]={s=570},  -- Fortified Cloak
	[9813]={s=825},  -- Fortified Gauntlets
	[9814]={s=733},  -- Fortified Belt
	[9815]={s=1664},  -- Fortified Leggings
	[9816]={s=1781},  -- Fortified Shield
	[9817]={s=1426},  -- Fortified Spaulders
	[9818]={s=1682},  -- Fortified Chain
	[9819]={s=2726},  -- Durable Tunic
	[9820]={s=1541},  -- Durable Boots
	[9821]={s=871},  -- Durable Bracers
	[9822]={s=1192},  -- Durable Cape
	[9823]={s=965},  -- Durable Gloves
	[9824]={s=1599},  -- Durable Shoulders
	[9825]={s=2355},  -- Durable Pants
	[9826]={s=2600},  -- Durable Robe
	[9827]={s=1114},  -- Scaled Leather Belt
	[9828]={s=1845},  -- Scaled Leather Boots
	[9829]={s=1020},  -- Scaled Leather Bracers
	[9830]={s=3489},  -- Scaled Shield
	[9831]={s=1233},  -- Scaled Cloak
	[9832]={s=1248},  -- Scaled Leather Gloves
	[9833]={s=3031},  -- Scaled Leather Leggings
	[9834]={s=2074},  -- Scaled Leather Shoulders
	[9835]={s=3053},  -- Scaled Leather Tunic
	[9836]={s=3677},  -- Banded Armor
	[9837]={s=1287},  -- Banded Bracers
	[9838]={s=1174},  -- Banded Cloak
	[9839]={s=1426},  -- Banded Gauntlets
	[9840]={s=1432},  -- Banded Girdle
	[9841]={s=3163},  -- Banded Leggings
	[9842]={s=2391},  -- Banded Pauldrons
	[9843]={s=3739},  -- Banded Shield
	[9844]={s=3709},  -- Conjurer's Vest
	[9845]={s=2136},  -- Conjurer's Shoes
	[9846]={s=1429},  -- Conjurer's Bracers
	[9847]={s=1779},  -- Conjurer's Cloak
	[9848]={s=1584},  -- Conjurer's Gloves
	[9849]={s=2385},  -- Conjurer's Hood
	[9850]={s=2394},  -- Conjurer's Mantle
	[9851]={s=3524},  -- Conjurer's Breeches
	[9852]={s=3820},  -- Conjurer's Robe
	[9853]={s=1368},  -- Conjurer's Cinch
	[9854]={s=4935},  -- Archer's Jerkin
	[9855]={s=1895},  -- Archer's Belt
	[9856]={s=2839},  -- Archer's Boots
	[9857]={s=1570},  -- Archer's Bracers
	[9858]={s=4882},  -- Archer's Buckler
	[9859]={s=2871},  -- Archer's Cap
	[9860]={s=2382},  -- Archer's Cloak
	[9861]={s=1753},  -- Archer's Gloves
	[9862]={s=4260},  -- Archer's Trousers
	[9863]={s=3207},  -- Archer's Shoulderpads
	[9864]={s=3527},  -- Renegade Boots
	[9865]={s=1942},  -- Renegade Bracers
	[9866]={s=5605},  -- Renegade Chestguard
	[9867]={s=1778},  -- Renegade Cloak
	[9868]={s=2160},  -- Renegade Gauntlets
	[9869]={s=2225},  -- Renegade Belt
	[9870]={s=3686},  -- Renegade Circlet
	[9871]={s=5425},  -- Renegade Leggings
	[9872]={s=4101},  -- Renegade Pauldrons
	[9873]={s=5828},  -- Renegade Shield
	[9874]={s=5801},  -- Sorcerer Drape
	[9875]={s=2139},  -- Sorcerer Sash
	[9876]={s=3146},  -- Sorcerer Slippers
	[9877]={s=2708},  -- Sorcerer Cloak
	[9878]={s=3424},  -- Sorcerer Hat
	[9879]={s=1964},  -- Sorcerer Bracelets
	[9880]={s=2130},  -- Sorcerer Gloves
	[9881]={s=3464},  -- Sorcerer Mantle
	[9882]={s=6209},  -- Sorcerer Sphere
	[9883]={s=5026},  -- Sorcerer Pants
	[9884]={s=5448},  -- Sorcerer Robe
	[9885]={s=4179},  -- Huntsman's Boots
	[9886]={s=2589},  -- Huntsman's Bands
	[9887]={s=7071},  -- Huntsman's Armor
	[9889]={s=4240},  -- Huntsman's Cap
	[9890]={s=2919},  -- Huntsman's Cape
	[9891]={s=2636},  -- Huntsman's Belt
	[9892]={s=2857},  -- Huntsman's Gloves
	[9893]={s=6689},  -- Huntsman's Leggings
	[9894]={s=4661},  -- Huntsman's Shoulders
	[9895]={s=5221},  -- Jazeraint Boots
	[9896]={s=2913},  -- Jazeraint Bracers
	[9897]={s=7368},  -- Jazeraint Chestguard
	[9898]={s=2718},  -- Jazeraint Cloak
	[9899]={s=7920},  -- Jazeraint Shield
	[9900]={s=3195},  -- Jazeraint Gauntlets
	[9901]={s=3294},  -- Jazeraint Belt
	[9902]={s=5357},  -- Jazeraint Helm
	[9903]={s=7742},  -- Jazeraint Leggings
	[9904]={s=5420},  -- Jazeraint Pauldrons
	[9905]={s=8251},  -- Royal Blouse
	[9906]={s=3043},  -- Royal Sash
	[9907]={s=4581},  -- Royal Boots
	[9908]={s=4257},  -- Royal Cape
	[9909]={s=2848},  -- Royal Bands
	[9910]={s=3087},  -- Royal Gloves
	[9911]={s=7228},  -- Royal Trousers
	[9912]={s=5037},  -- Royal Amice
	[9913]={s=8490},  -- Royal Gown
	[9914]={s=7557},  -- Royal Scepter
	[9915]={s=5091},  -- Royal Headband
	[9916]={s=3566},  -- Tracker's Belt
	[9917]={s=5519},  -- Tracker's Boots
	[9918]={s=10212},  -- Brigade Defender
	[9919]={s=5149},  -- Tracker's Cloak
	[9920]={s=3721},  -- Tracker's Gloves
	[9921]={s=6050},  -- Tracker's Headband
	[9922]={s=8745},  -- Tracker's Leggings
	[9923]={s=6095},  -- Tracker's Shoulderpads
	[9924]={s=10276},  -- Tracker's Tunic
	[9925]={s=3789},  -- Tracker's Wristguards
	[9926]={s=6368},  -- Brigade Boots
	[9927]={s=3927},  -- Brigade Bracers
	[9928]={s=9930},  -- Brigade Breastplate
	[9929]={s=3662},  -- Brigade Cloak
	[9930]={s=4287},  -- Brigade Gauntlets
	[9931]={s=4303},  -- Brigade Girdle
	[9932]={s=6995},  -- Brigade Circlet
	[9933]={s=9394},  -- Brigade Leggings
	[9934]={s=6577},  -- Brigade Pauldrons
	[9935]={s=10097},  -- Embossed Plate Shield
	[9936]={s=6403},  -- Abjurer's Boots
	[9937]={s=4004},  -- Abjurer's Bands
	[9938]={s=6029},  -- Abjurer's Cloak
	[9939]={s=4317},  -- Abjurer's Gloves
	[9940]={s=6954},  -- Abjurer's Hood
	[9941]={s=6523},  -- Abjurer's Mantle
	[9942]={s=9341},  -- Abjurer's Pants
	[9943]={s=11271},  -- Abjurer's Robe
	[9944]={s=8570},  -- Abjurer's Crystal
	[9945]={s=4124},  -- Abjurer's Sash
	[9946]={s=11396},  -- Abjurer's Tunic
	[9947]={s=5193},  -- Chieftain's Belt
	[9948]={s=8365},  -- Chieftain's Boots
	[9949]={s=4855},  -- Chieftain's Bracers
	[9950]={s=13418},  -- Chieftain's Breastplate
	[9951]={s=6795},  -- Chieftain's Cloak
	[9952]={s=5255},  -- Chieftain's Gloves
	[9953]={s=8467},  -- Chieftain's Headdress
	[9954]={s=12125},  -- Chieftain's Leggings
	[9955]={s=8530},  -- Chieftain's Shoulders
	[9956]={s=5130},  -- Warmonger's Bracers
	[9957]={s=13753},  -- Warmonger's Chestpiece
	[9958]={s=14724},  -- Warmonger's Buckler
	[9959]={s=4803},  -- Warmonger's Cloak
	[9960]={s=5623},  -- Warmonger's Gauntlets
	[9961]={s=5644},  -- Warmonger's Belt
	[9962]={s=9218},  -- Warmonger's Greaves
	[9963]={s=9211},  -- Warmonger's Circlet
	[9964]={s=13190},  -- Warmonger's Leggings
	[9965]={s=9973},  -- Warmonger's Pauldrons
	[9966]={s=6743},  -- Embossed Plate Armor
	[9967]={s=2900},  -- Embossed Plate Gauntlets
	[9968]={s=2695},  -- Embossed Plate Girdle
	[9969]={s=3964},  -- Embossed Plate Helmet
	[9970]={s=5730},  -- Embossed Plate Leggings
	[9971]={s=3995},  -- Embossed Plate Pauldrons
	[9972]={s=2475},  -- Embossed Plate Bracers
	[9973]={s=3727},  -- Embossed Plate Boots
	[9974]={s=16449},  -- Overlord's Shield
	[9978]={s=0},  -- Gahz'ridian Detector
	[9998]={s=4815},  -- Black Mageweave Vest
	[9999]={s=4832},  -- Black Mageweave Leggings
	[10000]={s=0},  -- Margol's Horn
	[10001]={s=5257},  -- Black Mageweave Robe
	[10002]={s=5276},  -- Shadoweave Pants
	[10003]={s=2859},  -- Black Mageweave Gloves
	[10004]={s=5738},  -- Shadoweave Robe
	[10005]={s=0},  -- Margol's Gigantic Horn
	[10007]={s=5799},  -- Red Mageweave Vest
	[10008]={s=4365},  -- White Bandit Mask
	[10009]={s=5284},  -- Red Mageweave Pants
	[10018]={s=3275},  -- Red Mageweave Gloves
	[10019]={s=3944},  -- Dreamweave Gloves
	[10021]={s=7946},  -- Dreamweave Vest
	[10022]={s=0},  -- Proof of Deed
	[10023]={s=3334},  -- Shadoweave Gloves
	[10024]={s=5421},  -- Black Mageweave Headband
	[10025]={s=6790},  -- Shadoweave Mask
	[10026]={s=5459},  -- Black Mageweave Boots
	[10027]={s=5479},  -- Black Mageweave Shoulders
	[10028]={s=5938},  -- Shadoweave Shoulders
	[10029]={s=5391},  -- Red Mageweave Shoulders
	[10030]={s=6007},  -- Admiral's Hat
	[10031]={s=6030},  -- Shadoweave Boots
	[10033]={s=6075},  -- Red Mageweave Headband
	[10034]={s=2000},  -- Tuxedo Shirt
	[10035]={s=1735},  -- Tuxedo Pants
	[10036]={s=1741},  -- Tuxedo Jacket
	[10040]={s=1767},  -- White Wedding Dress
	[10041]={s=7161},  -- Dreamweave Circlet
	[10042]={s=6644},  -- Cindercloth Robe
	[10043]={s=2033},  -- Pious Legwraps
	[10044]={s=6765},  -- Cindercloth Boots
	[10045]={s=23},  -- Simple Linen Pants
	[10046]={s=32},  -- Simple Linen Boots
	[10047]={s=164},  -- Simple Kilt
	[10048]={s=935},  -- Colorful Kilt
	[10050]={s=2500},  -- Mageweave Bag
	[10051]={s=2500},  -- Red Mageweave Bag
	[10052]={s=1500},  -- Orange Martial Shirt
	[10053]={s=4499},  -- Simple Black Dress
	[10054]={s=3000},  -- Lavender Mageweave Shirt
	[10055]={s=3000},  -- Pink Mageweave Shirt
	[10056]={s=1500},  -- Orange Mageweave Shirt
	[10057]={s=12711},  -- Duskwoven Tunic
	[10058]={s=7083},  -- Duskwoven Sandals
	[10059]={s=4739},  -- Duskwoven Bracers
	[10060]={s=6667},  -- Duskwoven Cape
	[10061]={s=7661},  -- Duskwoven Turban
	[10062]={s=4758},  -- Duskwoven Gloves
	[10063]={s=7165},  -- Duskwoven Amice
	[10064]={s=10774},  -- Duskwoven Pants
	[10065]={s=12153},  -- Duskwoven Robe
	[10066]={s=4220},  -- Duskwoven Sash
	[10067]={s=5295},  -- Righteous Waistguard
	[10068]={s=9128},  -- Righteous Boots
	[10069]={s=5335},  -- Righteous Bracers
	[10070]={s=15482},  -- Righteous Armor
	[10071]={s=8063},  -- Righteous Cloak
	[10072]={s=6177},  -- Righteous Gloves
	[10073]={s=9858},  -- Righteous Helmet
	[10074]={s=13985},  -- Righteous Leggings
	[10075]={s=9369},  -- Righteous Spaulders
	[10076]={s=6571},  -- Lord's Armguards
	[10077]={s=16968},  -- Lord's Breastplate
	[10078]={s=18642},  -- Lord's Crest
	[10079]={s=6370},  -- Lord's Cape
	[10080]={s=7319},  -- Lord's Gauntlets
	[10081]={s=7345},  -- Lord's Girdle
	[10082]={s=10752},  -- Lord's Boots
	[10083]={s=10745},  -- Lord's Crown
	[10084]={s=15246},  -- Lord's Legguards
	[10085]={s=11529},  -- Lord's Pauldrons
	[10086]={s=8438},  -- Gothic Plate Armor
	[10087]={s=3393},  -- Gothic Plate Gauntlets
	[10088]={s=3154},  -- Gothic Plate Girdle
	[10089]={s=4749},  -- Gothic Sabatons
	[10090]={s=5148},  -- Gothic Plate Helmet
	[10091]={s=7441},  -- Gothic Plate Leggings
	[10092]={s=5602},  -- Gothic Plate Spaulders
	[10093]={s=18903},  -- Revenant Deflector
	[10094]={s=3311},  -- Gothic Plate Vambraces
	[10095]={s=10295},  -- Councillor's Boots
	[10096]={s=6130},  -- Councillor's Cuffs
	[10097]={s=10991},  -- Councillor's Circlet
	[10098]={s=8736},  -- Councillor's Cloak
	[10099]={s=6567},  -- Councillor's Gloves
	[10100]={s=11108},  -- Councillor's Shoulders
	[10101]={s=15756},  -- Councillor's Pants
	[10102]={s=15020},  -- Councillor's Robes
	[10103]={s=5687},  -- Councillor's Sash
	[10104]={s=15137},  -- Councillor's Tunic
	[10105]={s=19942},  -- Wanderer's Armor
	[10106]={s=12120},  -- Wanderer's Boots
	[10107]={s=7218},  -- Wanderer's Bracers
	[10108]={s=8203},  -- Wanderer's Cloak
	[10109]={s=7273},  -- Wanderer's Belt
	[10110]={s=7947},  -- Wanderer's Gloves
	[10111]={s=13444},  -- Wanderer's Hat
	[10112]={s=19071},  -- Wanderer's Leggings
	[10113]={s=13541},  -- Wanderer's Shoulders
	[10118]={s=23381},  -- Ornate Breastplate
	[10119]={s=16676},  -- Ornate Greaves
	[10120]={s=8797},  -- Ornate Cloak
	[10121]={s=10515},  -- Ornate Gauntlets
	[10122]={s=9007},  -- Ornate Girdle
	[10123]={s=15239},  -- Ornate Circlet
	[10124]={s=20396},  -- Ornate Legguards
	[10125]={s=14551},  -- Ornate Pauldrons
	[10126]={s=8865},  -- Ornate Bracers
	[10127]={s=4350},  -- Revenant Bracers
	[10128]={s=11907},  -- Revenant Chestplate
	[10129]={s=4689},  -- Revenant Gauntlets
	[10130]={s=4706},  -- Revenant Girdle
	[10131]={s=7085},  -- Revenant Boots
	[10132]={s=7608},  -- Revenant Helmet
	[10133]={s=10792},  -- Revenant Leggings
	[10134]={s=7664},  -- Revenant Shoulders
	[10135]={s=20663},  -- High Councillor's Tunic
	[10136]={s=8530},  -- High Councillor's Bracers
	[10137]={s=13484},  -- High Councillor's Boots
	[10138]={s=12274},  -- High Councillor's Cloak
	[10139]={s=14258},  -- High Councillor's Circlet
	[10140]={s=9085},  -- High Councillor's Gloves
	[10141]={s=20103},  -- High Councillor's Pants
	[10142]={s=13401},  -- High Councillor's Mantle
	[10143]={s=19772},  -- High Councillor's Robe
	[10144]={s=8164},  -- High Councillor's Sash
	[10145]={s=9755},  -- Mighty Girdle
	[10146]={s=16194},  -- Mighty Boots
	[10147]={s=10319},  -- Mighty Armsplints
	[10148]={s=11273},  -- Mighty Cloak
	[10149]={s=10915},  -- Mighty Gauntlets
	[10150]={s=17254},  -- Mighty Helmet
	[10151]={s=25456},  -- Mighty Tunic
	[10152]={s=24333},  -- Mighty Leggings
	[10153]={s=17444},  -- Mighty Spaulders
	[10154]={s=13337},  -- Mercurial Girdle
	[10155]={s=20168},  -- Mercurial Greaves
	[10156]={s=12794},  -- Mercurial Bracers
	[10157]={s=31216},  -- Mercurial Breastplate
	[10158]={s=31040},  -- Mercurial Guard
	[10159]={s=11444},  -- Mercurial Cloak
	[10160]={s=19948},  -- Mercurial Circlet
	[10161]={s=12713},  -- Mercurial Gauntlets
	[10162]={s=28137},  -- Mercurial Legguards
	[10163]={s=20264},  -- Mercurial Pauldrons
	[10164]={s=14808},  -- Templar Chestplate
	[10165]={s=6240},  -- Templar Gauntlets
	[10166]={s=5908},  -- Templar Girdle
	[10167]={s=9429},  -- Templar Boots
	[10168]={s=10032},  -- Templar Crown
	[10169]={s=14230},  -- Templar Legplates
	[10170]={s=10105},  -- Templar Pauldrons
	[10171]={s=6018},  -- Templar Bracers
	[10172]={s=9603},  -- Mystical Mantle
	[10173]={s=5718},  -- Mystical Bracers
	[10174]={s=8121},  -- Mystical Cape
	[10175]={s=9010},  -- Mystical Headwrap
	[10176]={s=5689},  -- Mystical Gloves
	[10177]={s=12833},  -- Mystical Leggings
	[10178]={s=14475},  -- Mystical Robe
	[10179]={s=8632},  -- Mystical Boots
	[10180]={s=5141},  -- Mystical Belt
	[10181]={s=14640},  -- Mystical Armor
	[10182]={s=18370},  -- Swashbuckler's Breastplate
	[10183]={s=10954},  -- Swashbuckler's Boots
	[10184]={s=6523},  -- Swashbuckler's Bracers
	[10185]={s=7412},  -- Swashbuckler's Cape
	[10186]={s=6966},  -- Swashbuckler's Gloves
	[10187]={s=11785},  -- Swashbuckler's Eyepatch
	[10188]={s=16717},  -- Swashbuckler's Leggings
	[10189]={s=11872},  -- Swashbuckler's Shoulderpads
	[10190]={s=6669},  -- Swashbuckler's Belt
	[10191]={s=7777},  -- Crusader's Armguards
	[10192]={s=13212},  -- Crusader's Boots
	[10193]={s=19775},  -- Crusader's Armor
	[10194]={s=7345},  -- Crusader's Cloak
	[10195]={s=19221},  -- Crusader's Shield
	[10196]={s=7593},  -- Crusader's Gauntlets
	[10197]={s=7623},  -- Crusader's Belt
	[10198]={s=12167},  -- Crusader's Helm
	[10199]={s=17261},  -- Crusader's Leggings
	[10200]={s=12314},  -- Crusader's Pauldrons
	[10201]={s=5960},  -- Overlord's Greaves
	[10202]={s=3988},  -- Overlord's Vambraces
	[10203]={s=10397},  -- Overlord's Chestplate
	[10204]={s=19888},  -- Heavy Lamellar Shield
	[10205]={s=4316},  -- Overlord's Gauntlets
	[10206]={s=4048},  -- Overlord's Girdle
	[10207]={s=6695},  -- Overlord's Crown
	[10208]={s=9586},  -- Overlord's Legplates
	[10209]={s=7216},  -- Overlord's Spaulders
	[10210]={s=12845},  -- Elegant Mantle
	[10211]={s=12276},  -- Elegant Boots
	[10212]={s=11069},  -- Elegant Cloak
	[10213]={s=7850},  -- Elegant Bracers
	[10214]={s=8271},  -- Elegant Gloves
	[10215]={s=17387},  -- Elegant Robes
	[10216]={s=7180},  -- Elegant Belt
	[10217]={s=16688},  -- Elegant Leggings
	[10218]={s=17589},  -- Elegant Tunic
	[10219]={s=12011},  -- Elegant Circlet
	[10220]={s=23263},  -- Nightshade Tunic
	[10221]={s=9148},  -- Nightshade Girdle
	[10222]={s=14462},  -- Nightshade Boots
	[10223]={s=9466},  -- Nightshade Armguards
	[10224]={s=10755},  -- Nightshade Cloak
	[10225]={s=10012},  -- Nightshade Gloves
	[10226]={s=16616},  -- Nightshade Helmet
	[10227]={s=23348},  -- Nightshade Leggings
	[10228]={s=15940},  -- Nightshade Spaulders
	[10229]={s=10331},  -- Engraved Bracers
	[10230]={s=25686},  -- Engraved Breastplate
	[10231]={s=9815},  -- Engraved Cape
	[10232]={s=11732},  -- Engraved Gauntlets
	[10233]={s=11106},  -- Engraved Girdle
	[10234]={s=17801},  -- Engraved Boots
	[10235]={s=16896},  -- Engraved Helm
	[10236]={s=22615},  -- Engraved Leggings
	[10237]={s=16287},  -- Engraved Pauldrons
	[10238]={s=7650},  -- Heavy Lamellar Boots
	[10239]={s=4962},  -- Heavy Lamellar Vambraces
	[10240]={s=12576},  -- Heavy Lamellar Chestpiece
	[10241]={s=8425},  -- Heavy Lamellar Helm
	[10242]={s=5318},  -- Heavy Lamellar Gauntlets
	[10243]={s=5035},  -- Heavy Lamellar Girdle
	[10244]={s=12039},  -- Heavy Lamellar Leggings
	[10245]={s=8548},  -- Heavy Lamellar Pauldrons
	[10246]={s=21542},  -- Master's Vest
	[10247]={s=14707},  -- Master's Boots
	[10248]={s=9371},  -- Master's Bracers
	[10249]={s=13435},  -- Master's Cloak
	[10250]={s=14866},  -- Master's Hat
	[10251]={s=9946},  -- Master's Gloves
	[10252]={s=20959},  -- Master's Leggings
	[10253]={s=15024},  -- Master's Mantle
	[10254]={s=22164},  -- Master's Robe
	[10255]={s=8934},  -- Master's Belt
	[10256]={s=10675},  -- Adventurer's Bracers
	[10257]={s=16877},  -- Adventurer's Boots
	[10258]={s=12292},  -- Adventurer's Cape
	[10259]={s=11335},  -- Adventurer's Belt
	[10260]={s=11945},  -- Adventurer's Gloves
	[10261]={s=17985},  -- Adventurer's Bandana
	[10262]={s=25272},  -- Adventurer's Legguards
	[10263]={s=18116},  -- Adventurer's Shoulders
	[10264]={s=26729},  -- Adventurer's Tunic
	[10265]={s=13904},  -- Masterwork Bracers
	[10266]={s=32310},  -- Masterwork Breastplate
	[10267]={s=13337},  -- Masterwork Cape
	[10268]={s=14758},  -- Masterwork Gauntlets
	[10269]={s=14106},  -- Masterwork Girdle
	[10270]={s=22396},  -- Masterwork Boots
	[10271]={s=32592},  -- Masterwork Shield
	[10272]={s=20865},  -- Masterwork Circlet
	[10273]={s=29323},  -- Masterwork Legplates
	[10274]={s=21118},  -- Masterwork Pauldrons
	[10275]={s=16204},  -- Emerald Breastplate
	[10276]={s=9847},  -- Emerald Sabatons
	[10277]={s=6985},  -- Emerald Gauntlets
	[10278]={s=6239},  -- Emerald Girdle
	[10279]={s=11188},  -- Emerald Helm
	[10280]={s=15723},  -- Emerald Legplates
	[10281]={s=11272},  -- Emerald Pauldrons
	[10282]={s=6712},  -- Emerald Vambraces
	[10283]={s=0},  -- Wolf Heart Samples
	[10285]={s=1000},  -- Shadow Silk
	[10286]={s=400},  -- Heart of the Wild
	[10287]={s=964},  -- Greenweave Mantle
	[10288]={s=1410},  -- Sage's Circlet
	[10289]={s=1557},  -- Durable Hat
	[10290]={s=625},  -- Pink Dye
	[10298]={s=1243},  -- Gnomeregan Band
	[10299]={s=3778},  -- Gnomeregan Amulet
	[10300]={s=1250},  -- Pattern: Red Mageweave Vest
	[10301]={s=1250},  -- Pattern: White Bandit Mask
	[10302]={s=1250},  -- Pattern: Red Mageweave Pants
	[10305]={s=100},  -- Scroll of Protection IV
	[10306]={s=100},  -- Scroll of Spirit IV
	[10307]={s=112},  -- Scroll of Stamina IV
	[10308]={s=112},  -- Scroll of Intellect IV
	[10309]={s=125},  -- Scroll of Agility IV
	[10310]={s=125},  -- Scroll of Strength IV
	[10311]={s=750},  -- Pattern: Orange Martial Shirt
	[10312]={s=1500},  -- Pattern: Red Mageweave Gloves
	[10314]={s=1000},  -- Pattern: Lavender Mageweave Shirt
	[10315]={s=1750},  -- Pattern: Red Mageweave Shoulders
	[10316]={s=200},  -- Pattern: Colorful Kilt
	[10317]={s=1000},  -- Pattern: Pink Mageweave Shirt
	[10318]={s=1750},  -- Pattern: Admiral's Hat
	[10320]={s=1750},  -- Pattern: Red Mageweave Headband
	[10321]={s=1125},  -- Pattern: Tuxedo Shirt
	[10323]={s=1125},  -- Pattern: Tuxedo Pants
	[10325]={s=2500},  -- Pattern: White Wedding Dress
	[10326]={s=1250},  -- Pattern: Tuxedo Jacket
	[10327]={s=0},  -- Horn of Echeyakee
	[10328]={s=6992},  -- Scarlet Chestpiece
	[10329]={s=2507},  -- Scarlet Belt
	[10330]={s=9587},  -- Scarlet Leggings
	[10331]={s=2728},  -- Scarlet Gauntlets
	[10332]={s=3790},  -- Scarlet Boots
	[10333]={s=2314},  -- Scarlet Wristguards
	[10338]={s=0},  -- Fresh Zhevra Carcass
	[10358]={s=2421},  -- Duracin Bracers
	[10359]={s=2430},  -- Everlast Boots
	[10360]={s=1250},  -- Black Kingsnake
	[10361]={s=1250},  -- Brown Snake
	[10362]={s=24760},  -- Ornate Shield
	[10363]={s=27396},  -- Engraved Wall
	[10364]={s=24938},  -- Templar Shield
	[10365]={s=26276},  -- Emerald Shield
	[10366]={s=32052},  -- Demon Guard
	[10367]={s=32971},  -- Hyperion Shield
	[10368]={s=17868},  -- Imbued Plate Armor
	[10369]={s=7377},  -- Imbued Plate Gauntlets
	[10370]={s=6985},  -- Imbued Plate Girdle
	[10371]={s=11149},  -- Imbued Plate Greaves
	[10372]={s=11750},  -- Imbued Plate Helmet
	[10373]={s=17336},  -- Imbued Plate Leggings
	[10374]={s=11837},  -- Imbued Plate Pauldrons
	[10375]={s=7116},  -- Imbued Plate Vambraces
	[10376]={s=12519},  -- Commander's Boots
	[10377]={s=7978},  -- Commander's Vambraces
	[10378]={s=19466},  -- Commander's Armor
	[10379]={s=13290},  -- Commander's Helm
	[10380]={s=8468},  -- Commander's Gauntlets
	[10381]={s=8094},  -- Commander's Girdle
	[10382]={s=18808},  -- Commander's Leggings
	[10383]={s=12521},  -- Commander's Pauldrons
	[10384]={s=20370},  -- Hyperion Armor
	[10385]={s=13247},  -- Hyperion Greaves
	[10386]={s=8865},  -- Hyperion Gauntlets
	[10387]={s=8475},  -- Hyperion Girdle
	[10388]={s=14068},  -- Hyperion Helm
	[10389]={s=19770},  -- Hyperion Legplates
	[10390]={s=14175},  -- Hyperion Pauldrons
	[10391]={s=8193},  -- Hyperion Vambraces
	[10392]={s=1250},  -- Crimson Snake
	[10393]={s=1250},  -- Cockroach
	[10394]={s=1250},  -- Prairie Dog Whistle
	[10398]={s=1000},  -- Mechanical Chicken
	[10399]={s=1467},  -- Blackened Defias Armor
	[10400]={s=563},  -- Blackened Defias Leggings
	[10401]={s=255},  -- Blackened Defias Gloves
	[10402]={s=385},  -- Blackened Defias Boots
	[10403]={s=451},  -- Blackened Defias Belt
	[10404]={s=864},  -- Durable Belt
	[10405]={s=409},  -- Bandit Shoulders
	[10406]={s=1976},  -- Scaled Leather Headband
	[10407]={s=431},  -- Raider's Shoulderpads
	[10408]={s=2390},  -- Banded Helm
	[10409]={s=2409},  -- Banded Boots
	[10410]={s=1256},  -- Leggings of the Fang
	[10411]={s=787},  -- Footpads of the Fang
	[10412]={s=405},  -- Belt of the Fang
	[10413]={s=307},  -- Gloves of the Fang
	[10414]={s=0},  -- Sample Snapjaw Shell
	[10418]={s=16464},  -- Glimmering Mithril Insignia
	[10420]={s=0},  -- Skull of the Coldbringer
	[10421]={s=32},  -- Rough Copper Vest
	[10423]={s=2842},  -- Silvered Bronze Leggings
	[10424]={s=750},  -- Plans: Silvered Bronze Leggings
	[10438]={s=0},  -- Felix's Box
	[10439]={s=0},  -- Durnan's Scalding Mornbrew
	[10440]={s=0},  -- Nori's Mug
	[10441]={s=0},  -- Glowing Shard
	[10442]={s=0},  -- Mysterious Artifact
	[10443]={s=0},  -- Singed Letter
	[10444]={s=0},  -- Standard Issue Flare Gun
	[10445]={s=0},  -- Drawing Kit
	[10446]={s=0},  -- Heart of Obsidion
	[10447]={s=0},  -- Head of Lathoric the Black
	[10450]={s=396},  -- Undamaged Hippogryph Feather
	[10454]={s=0},  -- Essence of Eranikus
	[10455]={s=6464},  -- Chained Essence of Eranikus
	[10456]={s=0},  -- A Bulging Coin Purse
	[10457]={s=142},  -- Empty Sea Snail Shell
	[10458]={s=0},  -- Prayer to Elune
	[10459]={s=0},  -- Chief Sharptusk Thornmantle's Head
	[10460]={s=629},  -- Hakkar'i Blood
	[10461]={s=3082},  -- Shadowy Bracers
	[10462]={s=3608},  -- Shadowy Belt
	[10463]={s=1750},  -- Pattern: Shadoweave Mask
	[10464]={s=0},  -- Staff of Command
	[10465]={s=0},  -- Egg of Hakkar
	[10466]={s=0},  -- Atal'ai Stone Circle
	[10467]={s=0},  -- Trader's Satchel
	[10479]={s=24},  -- Kovic's Trading Satchel
	[10498]={s=16},  -- Gyromatic Micro-Adjustor
	[10499]={s=2105},  -- Bright-Eye Goggles
	[10500]={s=3478},  -- Fire Goggles
	[10501]={s=4398},  -- Catseye Ultra Goggles
	[10502]={s=4088},  -- Spellpower Goggles Xtreme
	[10503]={s=5169},  -- Rose Colored Goggles
	[10504]={s=7770},  -- Green Lens
	[10505]={s=250},  -- Solid Blasting Powder
	[10506]={s=5227},  -- Deepdive Helmet
	[10507]={s=350},  -- Solid Dynamite
	[10508]={s=8958},  -- Mithril Blunderbuss
	[10509]={s=0},  -- Heart of Flame
	[10510]={s=11369},  -- Mithril Heavy-bore Rifle
	[10511]={s=0},  -- Golem Oil
	[10512]={s=2},  -- Hi-Impact Mithril Slugs
	[10513]={s=5},  -- Mithril Gyro-Shot
	[10514]={s=750},  -- Mithril Frag Bomb
	[10515]={s=0},  -- Torch of Retribution
	[10518]={s=4696},  -- Parachute Cloak
	[10538]={s=0},  -- Tablet of Beth'Amara
	[10539]={s=0},  -- Tablet of Jin'yael
	[10540]={s=0},  -- Tablet of Markri
	[10541]={s=0},  -- Tablet of Sael'hai
	[10542]={s=5255},  -- Goblin Mining Helmet
	[10543]={s=3517},  -- Goblin Construction Helmet
	[10544]={s=25},  -- Thistlewood Maul
	[10545]={s=3929},  -- Gnomish Goggles
	[10546]={s=1500},  -- Deadly Scope
	[10547]={s=81},  -- Camping Knife
	[10548]={s=2500},  -- Sniper Scope
	[10549]={s=162},  -- Rancher's Trousers
	[10550]={s=48},  -- Wooly Mittens
	[10551]={s=0},  -- Thorium Plated Dagger
	[10552]={s=0},  -- Symbol of Ragnaros
	[10553]={s=131},  -- Foreman Vest
	[10554]={s=119},  -- Foreman Pants
	[10556]={s=0},  -- Stone Circle
	[10558]={s=250},  -- Gold Power Core
	[10559]={s=750},  -- Mithril Tube
	[10560]={s=1000},  -- Unstable Trigger
	[10561]={s=1000},  -- Mithril Casing
	[10562]={s=750},  -- Hi-Explosive Bomb
	[10563]={s=0},  -- Rubbing: Rune of Beth'Amara
	[10564]={s=0},  -- Rubbing: Rune of Jin'yael
	[10565]={s=0},  -- Rubbing: Rune of Markri
	[10566]={s=0},  -- Rubbing: Rune of Sael'hai
	[10567]={s=8725},  -- Quillshooter
	[10569]={s=0},  -- Hoard of the Black Dragonflight
	[10570]={s=15875},  -- Manslayer
	[10571]={s=10927},  -- Ebony Boneclub
	[10572]={s=9592},  -- Freezing Shard
	[10573]={s=13754},  -- Boneslasher
	[10574]={s=3775},  -- Corpseshroud
	[10575]={s=0},  -- Black Dragonflight Molt
	[10576]={s=6000},  -- Mithril Mechanical Dragonling
	[10577]={s=2000},  -- Goblin Mortar
	[10578]={s=3377},  -- Thoughtcast Boots
	[10581]={s=5310},  -- Death's Head Vestment
	[10582]={s=3606},  -- Briar Tredders
	[10583]={s=6191},  -- Quillward Harness
	[10584]={s=2905},  -- Stormgale Fists
	[10586]={s=750},  -- The Big One
	[10587]={s=1500},  -- Goblin Bomb Dispenser
	[10588]={s=5834},  -- Goblin Rocket Helmet
	[10589]={s=0},  -- Oathstone of Ysera's Dragonflight
	[10590]={s=0},  -- Pocked Black Box
	[10592]={s=150},  -- Catseye Elixir
	[10593]={s=0},  -- Imperfect Draenethyst Fragment
	[10597]={s=0},  -- Head of Magus Rimtori
	[10598]={s=0},  -- Hetaera's Bloodied Head
	[10599]={s=0},  -- Hetaera's Beaten Head
	[10600]={s=0},  -- Hetaera's Bruised Head
	[10601]={s=500},  -- Schematic: Bright-Eye Goggles
	[10602]={s=750},  -- Schematic: Deadly Scope
	[10603]={s=825},  -- Schematic: Catseye Ultra Goggles
	[10604]={s=825},  -- Schematic: Mithril Heavy-bore Rifle
	[10605]={s=875},  -- Schematic: Spellpower Goggles Xtreme
	[10606]={s=875},  -- Schematic: Parachute Cloak
	[10607]={s=900},  -- Schematic: Deepdive Helmet
	[10608]={s=950},  -- Schematic: Sniper Scope
	[10609]={s=1000},  -- Schematic: Mithril Mechanical Dragonling
	[10610]={s=0},  -- Hetaera's Blood
	[10620]={s=250},  -- Thorium Ore
	[10621]={s=0},  -- Runed Scroll
	[10622]={s=0},  -- Kadrak's Flag
	[10623]={s=24748},  -- Winter's Bite
	[10624]={s=17249},  -- Stinging Bow
	[10625]={s=27366},  -- Stealthblade
	[10626]={s=36732},  -- Ragehammer
	[10627]={s=26974},  -- Bludgeon of the Grinning Dog
	[10628]={s=29245},  -- Deathblow
	[10629]={s=8066},  -- Mistwalker Boots
	[10630]={s=8664},  -- Soulcatcher Halo
	[10631]={s=6086},  -- Murkwater Gauntlets
	[10632]={s=7624},  -- Slimescale Bracers
	[10633]={s=11684},  -- Silvershell Leggings
	[10634]={s=10812},  -- Mindseye Circle
	[10635]={s=14},  -- Painted Chain Leggings
	[10636]={s=6},  -- Nomadic Gloves
	[10637]={s=139},  -- Brewer's Gloves
	[10638]={s=210},  -- Long Draping Cape
	[10639]={s=0},  -- Hyacinth Mushroom
	[10640]={s=0},  -- Webwood Ichor
	[10641]={s=0},  -- Moonpetal Lily
	[10642]={s=0},  -- Iverron's Antidote
	[10643]={s=0},  -- Sealed Letter to Ag'tor
	[10644]={s=500},  -- Recipe: Goblin Rocket Fuel
	[10645]={s=750},  -- Gnomish Death Ray
	[10646]={s=500},  -- Goblin Sapper Charge
	[10647]={s=500},  -- Engineer's Ink
	[10648]={s=125},  -- Blank Parchment
	[10649]={s=0},  -- Nightmare Shard
	[10652]={s=30308},  -- Will of the Mountain Giant
	[10653]={s=1639},  -- Trailblazer Boots
	[10654]={s=965},  -- Jutebraid Gloves
	[10655]={s=9},  -- Sedgeweed Britches
	[10656]={s=14},  -- Barkmail Vest
	[10657]={s=933},  -- Talbar Mantle
	[10658]={s=1249},  -- Quagmire Galoshes
	[10659]={s=4662},  -- Shard of Afrasa
	[10660]={s=0},  -- First Mosh'aru Tablet
	[10661]={s=0},  -- Second Mosh'aru Tablet
	[10662]={s=0},  -- Filled Egg of Hakkar
	[10663]={s=0},  -- Essence of Hakkar
	[10664]={s=0},  -- A Note to Magus Rimtori
	[10678]={s=0},  -- Magatha's Note
	[10679]={s=0},  -- Andron's Note
	[10680]={s=0},  -- Jes'rimon's Note
	[10681]={s=0},  -- Xylem's Note
	[10682]={s=0},  -- Belnistrasz's Oathstone
	[10684]={s=500},  -- Colossal Parachute
	[10686]={s=21163},  -- Aegis of Battle
	[10687]={s=0},  -- Empty Vial Labeled #1
	[10688]={s=0},  -- Empty Vial Labeled #2
	[10689]={s=0},  -- Empty Vial Labeled #3
	[10690]={s=0},  -- Empty Vial Labeled #4
	[10691]={s=0},  -- Filled Vial Labeled #1
	[10692]={s=0},  -- Filled Vial Labeled #2
	[10693]={s=0},  -- Filled Vial Labeled #3
	[10694]={s=0},  -- Filled Vial Labeled #4
	[10695]={s=0},  -- Box of Empty Vials
	[10696]={s=41890},  -- Enchanted Azsharite Felbane Sword
	[10697]={s=42044},  -- Enchanted Azsharite Felbane Dagger
	[10698]={s=52747},  -- Enchanted Azsharite Felbane Staff
	[10699]={s=0},  -- Yeh'kinya's Bramble
	[10700]={s=4983},  -- Encarmine Boots
	[10701]={s=7536},  -- Boots of Zua'tec
	[10702]={s=5379},  -- Enormous Ogre Boots
	[10703]={s=16792},  -- Fiendish Skiv
	[10704]={s=13649},  -- Chillnail Splinter
	[10705]={s=3666},  -- Firwillow Wristbands
	[10706]={s=5521},  -- Nightscale Girdle
	[10707]={s=7772},  -- Steelsmith Greaves
	[10708]={s=8982},  -- Skullspell Orb
	[10709]={s=10953},  -- Pyrestone Orb
	[10710]={s=6130},  -- Dragonclaw Ring
	[10711]={s=8377},  -- Dragon's Blood Necklace
	[10712]={s=0},  -- Cuely's Elixir
	[10713]={s=500},  -- Plans: Inlaid Mithril Cylinder
	[10714]={s=0},  -- Crystallized Azsharite
	[10715]={s=0},  -- Kim'Jael's Scope
	[10716]={s=750},  -- Gnomish Shrink Ray
	[10717]={s=0},  -- Kim'Jael's Compass
	[10718]={s=0},  -- Kim'Jael's Wizzlegoober
	[10720]={s=750},  -- Gnomish Net-o-Matic Projector
	[10721]={s=3317},  -- Gnomish Harm Prevention Belt
	[10722]={s=0},  -- Kim'Jael's Stuffed Chicken
	[10724]={s=4696},  -- Gnomish Rocket Boots
	[10725]={s=1500},  -- Gnomish Battle Chicken
	[10726]={s=5520},  -- Gnomish Mind Control Cap
	[10727]={s=2000},  -- Goblin Dragon Gun
	[10728]={s=375},  -- Pattern: Black Swashbuckler's Shirt
	[10738]={s=0},  -- Shipment to Galvan
	[10739]={s=5292},  -- Ring of Fortitude
	[10740]={s=10692},  -- Centurion Legplates
	[10741]={s=10063},  -- Lordrec Helmet
	[10742]={s=9589},  -- Dragonflight Leggings
	[10743]={s=10830},  -- Drakefire Headguard
	[10744]={s=24159},  -- Axe of the Ebon Drake
	[10745]={s=8498},  -- Kaylari Shoulders
	[10746]={s=4549},  -- Runesteel Vambraces
	[10747]={s=2327},  -- Teacher's Sash
	[10748]={s=4380},  -- Wanderlust Boots
	[10749]={s=10554},  -- Avenguard Helm
	[10750]={s=35315},  -- Lifeforce Dirk
	[10751]={s=10634},  -- Gemburst Circlet
	[10752]={s=0},  -- Emerald Encrusted Chest
	[10753]={s=0},  -- Amulet of Grol
	[10754]={s=0},  -- Amulet of Sevine
	[10755]={s=0},  -- Amulet of Allistarj
	[10757]={s=0},  -- Ward of the Defiler
	[10758]={s=20144},  -- X'caliboar
	[10759]={s=0},  -- Severed Horn of the Defiler
	[10760]={s=2428},  -- Swine Fists
	[10761]={s=17193},  -- Coldrage Dagger
	[10762]={s=6903},  -- Robes of the Lich
	[10763]={s=5197},  -- Icemetal Barbute
	[10764]={s=10434},  -- Deathchill Armor
	[10765]={s=3367},  -- Bonefingers
	[10766]={s=9660},  -- Plaguerot Sprig
	[10767]={s=9652},  -- Savage Boar's Guard
	[10768]={s=4541},  -- Boar Champion's Belt
	[10769]={s=5277},  -- Glowing Eye of Mordresh
	[10770]={s=7835},  -- Mordresh's Lifeless Skull
	[10771]={s=2910},  -- Deathmage Sash
	[10772]={s=12170},  -- Glutton's Cleaver
	[10773]={s=0},  -- Hakkar'i Urn
	[10774]={s=5957},  -- Fleshhide Shoulders
	[10775]={s=6377},  -- Carapace of Tuten'kash
	[10776]={s=4799},  -- Silky Spider Cape
	[10777]={s=4014},  -- Arachnid Gloves
	[10778]={s=16930},  -- Necklace of Sanctuary
	[10779]={s=8807},  -- Demon's Blood
	[10780]={s=5542},  -- Mark of Hakkar
	[10781]={s=15071},  -- Hakkar'i Breastplate
	[10782]={s=4538},  -- Hakkar'i Shroud
	[10783]={s=11476},  -- Atal'ai Spaulders
	[10784]={s=18432},  -- Atal'ai Breastplate
	[10785]={s=13200},  -- Atal'ai Leggings
	[10786]={s=11977},  -- Atal'ai Boots
	[10787]={s=6382},  -- Atal'ai Gloves
	[10788]={s=5338},  -- Atal'ai Girdle
	[10789]={s=0},  -- Manual of Engineering Disciplines
	[10790]={s=0},  -- Gnome Engineer Membership Card
	[10791]={s=0},  -- Goblin Engineer Membership Card
	[10792]={s=0},  -- Nixx's Pledge of Secrecy
	[10793]={s=0},  -- Overspark's Pledge of Secrecy
	[10794]={s=0},  -- Oglethorpe's Pledge of Secrecy
	[10795]={s=5542},  -- Drakeclaw Band
	[10796]={s=8982},  -- Drakestone
	[10797]={s=35069},  -- Firebreather
	[10798]={s=6263},  -- Atal'alarion's Tusk Ring
	[10799]={s=39288},  -- Headspike
	[10800]={s=7562},  -- Darkwater Bracers
	[10801]={s=11704},  -- Slitherscale Boots
	[10802]={s=7831},  -- Wingveil Cloak
	[10803]={s=29441},  -- Blade of the Wretched
	[10804]={s=29551},  -- Fist of the Damned
	[10805]={s=29661},  -- Eater of the Dead
	[10806]={s=15146},  -- Vestments of the Atal'ai Prophet
	[10807]={s=15202},  -- Kilt of the Atal'ai Prophet
	[10808]={s=7629},  -- Gloves of the Atal'ai Prophet
	[10818]={s=0},  -- Yeh'kinya's Scroll
	[10819]={s=0},  -- Wildkin Feather
	[10820]={s=138},  -- Jackseed Belt
	[10821]={s=208},  -- Sower's Cloak
	[10822]={s=2500},  -- Dark Whelpling
	[10823]={s=17796},  -- Vanquisher's Sword
	[10824]={s=5930},  -- Amberglow Talisman
	[10826]={s=25501},  -- Staff of Lore
	[10827]={s=10238},  -- Surveyor's Tunic
	[10828]={s=40427},  -- Dire Nail
	[10829]={s=10680},  -- Dragon's Eye
	[10830]={s=750},  -- M73 Frag Grenade
	[10831]={s=0},  -- Fel Orb
	[10832]={s=0},  -- Fel Tracker Owner's Manual
	[10833]={s=8597},  -- Horns of Eranikus
	[10834]={s=0},  -- Felhound Tracker Kit
	[10835]={s=24645},  -- Crest of Supremacy
	[10836]={s=28989},  -- Rod of Corrosion
	[10837]={s=38801},  -- Tooth of Eranikus
	[10838]={s=34665},  -- Might of Hakkar
	[10839]={s=0},  -- Crystallized Note
	[10840]={s=0},  -- Crystallized Note
	[10841]={s=85},  -- Goldthorn Tea
	[10842]={s=17595},  -- Windscale Sarong
	[10843]={s=10595},  -- Featherskin Cape
	[10844]={s=44314},  -- Spire of Hakkar
	[10845]={s=14233},  -- Warrior's Embrace
	[10846]={s=16143},  -- Bloodshot Greaves
	[10847]={s=56921},  -- Dragon's Call
	[10858]={s=750},  -- Plans: Solid Iron Maul
	[10918]={s=42},  -- Wound Poison
	[10919]={s=214},  -- Apothecary Gloves
	[10920]={s=67},  -- Wound Poison II
	[10921]={s=125},  -- Wound Poison III
	[10922]={s=175},  -- Wound Poison IV
	[10938]={s=0},  -- Lesser Magic Essence
	[10939]={s=0},  -- Greater Magic Essence
	[10940]={s=0},  -- Strange Dust
	[10958]={s=0},  -- Hilary's Necklace
	[10959]={s=8750},  -- Demon Hide Sack
	[10978]={s=0},  -- Small Glimmering Shard
	[10998]={s=0},  -- Lesser Astral Essence
	[10999]={s=0},  -- Ironfel
	[11000]={s=0},  -- Shadowforge Key
	[11018]={s=146},  -- Un'Goro Soil
	[11020]={s=0},  -- Evergreen Pouch
	[11022]={s=250},  -- Packet of Tharlendris Seeds
	[11023]={s=2500},  -- Ancona Chicken
	[11024]={s=0},  -- Evergreen Herb Casing
	[11038]={s=200},  -- Formula: Enchant 2H Weapon - Lesser Spirit
	[11039]={s=200},  -- Formula: Enchant Cloak - Minor Agility
	[11040]={s=1},  -- Morrowgrain
	[11058]={s=0},  -- Sha'ni's Nose-Ring
	[11078]={s=0},  -- Relic Coffer Key
	[11079]={s=0},  -- Gor'tesh's Lopped Off Head
	[11080]={s=0},  -- Gor'tesh's Lopped Off Head
	[11081]={s=200},  -- Formula: Enchant Shield - Lesser Protection
	[11082]={s=0},  -- Greater Astral Essence
	[11083]={s=0},  -- Soul Dust
	[11084]={s=0},  -- Large Glimmering Shard
	[11086]={s=27403},  -- Jang'thraze the Protector
	[11098]={s=500},  -- Formula: Enchant Cloak - Lesser Shadow Resistance
	[11101]={s=625},  -- Formula: Enchant Bracer - Lesser Strength
	[11102]={s=0},  -- Unhatched Sprite Darter Egg
	[11103]={s=0},  -- Seed Voucher
	[11104]={s=0},  -- Large Compass
	[11105]={s=0},  -- Curled Map Parchment
	[11106]={s=0},  -- Lion-headed Key
	[11107]={s=0},  -- A Small Pack
	[11108]={s=0},  -- Faded Photograph
	[11109]={s=6},  -- Special Chicken Feed
	[11110]={s=2},  -- Chicken Egg
	[11112]={s=0},  -- Research Equipment
	[11113]={s=0},  -- Crate of Foodstuffs
	[11114]={s=0},  -- Dinosaur Bone
	[11116]={s=0},  -- A Mangled Journal
	[11118]={s=10795},  -- Archaedic Stone
	[11119]={s=0},  -- Milly's Harvest
	[11120]={s=30144},  -- Belgrom's Hammer
	[11121]={s=2941},  -- Darkwater Talwar
	[11122]={s=7162},  -- Carrot on a Stick
	[11123]={s=15037},  -- Rainstrider Leggings
	[11124]={s=16980},  -- Helm of Exile
	[11125]={s=0},  -- Grape Manifest
	[11126]={s=0},  -- Tablet of Kurniya
	[11127]={s=0},  -- Scavenged Goods
	[11128]={s=500},  -- Golden Rod
	[11129]={s=0},  -- Essence of the Elements
	[11130]={s=500},  -- Runed Golden Rod
	[11131]={s=0},  -- Hive Wall Sample
	[11132]={s=0},  -- Unused Scraping Vial
	[11133]={s=0},  -- Linken's Training Sword
	[11134]={s=0},  -- Lesser Mystic Essence
	[11135]={s=0},  -- Greater Mystic Essence
	[11136]={s=0},  -- Linken's Tempered Sword
	[11137]={s=0},  -- Vision Dust
	[11138]={s=0},  -- Small Glowing Shard
	[11139]={s=0},  -- Large Glowing Shard
	[11140]={s=0},  -- Prison Cell Key
	[11141]={s=0},  -- Bait
	[11142]={s=0},  -- Broken Samophlange
	[11143]={s=0},  -- Nugget Slug
	[11144]={s=1000},  -- Truesilver Rod
	[11145]={s=1250},  -- Runed Truesilver Rod
	[11146]={s=0},  -- Broken and Battered Samophlange
	[11147]={s=0},  -- Samophlange Manual Cover
	[11148]={s=0},  -- Samophlange Manual Page
	[11149]={s=0},  -- Samophlange Manual
	[11150]={s=750},  -- Formula: Enchant Gloves - Mining
	[11151]={s=750},  -- Formula: Enchant Gloves - Herbalism
	[11152]={s=750},  -- Formula: Enchant Gloves - Fishing
	[11162]={s=0},  -- Linken's Superior Sword
	[11163]={s=750},  -- Formula: Enchant Bracer - Lesser Deflection
	[11164]={s=750},  -- Formula: Enchant Weapon - Lesser Beastslayer
	[11165]={s=750},  -- Formula: Enchant Weapon - Lesser Elemental Slayer
	[11166]={s=1000},  -- Formula: Enchant Gloves - Skinning
	[11167]={s=1000},  -- Formula: Enchant Boots - Lesser Spirit
	[11168]={s=1000},  -- Formula: Enchant Shield - Lesser Block
	[11169]={s=0},  -- Book of Aquor
	[11172]={s=0},  -- Silvery Claws
	[11173]={s=0},  -- Irontree Heart
	[11174]={s=0},  -- Lesser Nether Essence
	[11175]={s=0},  -- Greater Nether Essence
	[11176]={s=0},  -- Dream Dust
	[11177]={s=0},  -- Small Radiant Shard
	[11178]={s=0},  -- Large Radiant Shard
	[11179]={s=0},  -- Golden Flame
	[11184]={s=0},  -- Blue Power Crystal
	[11185]={s=0},  -- Green Power Crystal
	[11186]={s=0},  -- Red Power Crystal
	[11187]={s=5},  -- Stemleaf Bracers
	[11188]={s=0},  -- Yellow Power Crystal
	[11189]={s=10},  -- Woodland Robes
	[11190]={s=5},  -- Viny Gloves
	[11191]={s=45},  -- Farmer's Boots
	[11192]={s=4},  -- Outfitter Gloves
	[11193]={s=16938},  -- Blazewind Breastplate
	[11194]={s=20404},  -- Prismscale Hauberk
	[11195]={s=13655},  -- Warforged Chestplate
	[11196]={s=16875},  -- Mindburst Medallion
	[11197]={s=0},  -- Dark Keeper Key
	[11202]={s=1100},  -- Formula: Enchant Shield - Stamina
	[11203]={s=1100},  -- Formula: Enchant Gloves - Advanced Mining
	[11204]={s=1100},  -- Formula: Enchant Bracer - Greater Spirit
	[11205]={s=1250},  -- Formula: Enchant Gloves - Advanced Herbalism
	[11206]={s=1250},  -- Formula: Enchant Cloak - Lesser Agility
	[11207]={s=3000},  -- Formula: Enchant Weapon - Fiery Weapon
	[11208]={s=1350},  -- Formula: Enchant Weapon - Demonslaying
	[11222]={s=0},  -- Head of Krom'zar
	[11223]={s=1450},  -- Formula: Enchant Bracer - Deflection
	[11224]={s=1450},  -- Formula: Enchant Shield - Frost Resistance
	[11225]={s=1550},  -- Formula: Enchant Bracer - Greater Stamina
	[11226]={s=1550},  -- Formula: Enchant Gloves - Riding Skill
	[11227]={s=0},  -- Piece of Krom'zar's Banner
	[11229]={s=1696},  -- Brightscale Girdle
	[11230]={s=0},  -- Encased Fiery Essence
	[11231]={s=0},  -- Altered Black Dragonflight Molt
	[11242]={s=0},  -- Evoroot
	[11243]={s=0},  -- Videre Elixir
	[11262]={s=8142},  -- Orb of Lorica
	[11263]={s=8419},  -- Nether Force Wand
	[11265]={s=16484},  -- Cragwood Maul
	[11266]={s=0},  -- Fractured Elemental Shard
	[11267]={s=0},  -- Elemental Shard Sample
	[11268]={s=0},  -- Head of Argelmach
	[11269]={s=0},  -- Intact Elemental Core
	[11270]={s=0},  -- Nixx's Signed Pledge
	[11282]={s=0},  -- Oglethorpe's Signed Pledge
	[11283]={s=0},  -- Overspark's Signed Pledge
	[11284]={s=1},  -- Accurate Slugs
	[11285]={s=2},  -- Jagged Arrow
	[11286]={s=0},  -- Thorium Shackles
	[11287]={s=104},  -- Lesser Magic Wand
	[11288]={s=465},  -- Greater Magic Wand
	[11289]={s=2148},  -- Lesser Mystic Wand
	[11290]={s=3157},  -- Greater Mystic Wand
	[11291]={s=1125},  -- Star Wood
	[11302]={s=7130},  -- Uther's Strength
	[11303]={s=636},  -- Fine Shortbow
	[11304]={s=972},  -- Fine Longbow
	[11305]={s=5162},  -- Dense Shortbow
	[11306]={s=3893},  -- Sturdy Recurve
	[11307]={s=13590},  -- Massive Longbow
	[11308]={s=15765},  -- Sylvan Shortbow
	[11309]={s=0},  -- The Heart of the Mountain
	[11310]={s=6598},  -- Flameseer Mantle
	[11311]={s=5110},  -- Emberscale Cape
	[11312]={s=0},  -- Lost Thunderbrew Recipe
	[11313]={s=0},  -- Ribbly's Head
	[11315]={s=0},  -- Bloodpetal Sprout
	[11316]={s=0},  -- Bloodpetal
	[11318]={s=0},  -- Atal'ai Haze
	[11319]={s=0},  -- Unloaded Zapper
	[11320]={s=0},  -- Bloodpetal Zapper
	[11324]={s=6250},  -- Explorer's Knapsack
	[11325]={s=150},  -- Dark Iron Ale Mug
	[11362]={s=250},  -- Medium Quiver
	[11366]={s=0},  -- Helendis Riverhorn's Letter
	[11367]={s=0},  -- Solomon's Plea to Bolvar
	[11368]={s=0},  -- Bolvar's Decree
	[11370]={s=500},  -- Dark Iron Ore
	[11371]={s=600},  -- Dark Iron Bar
	[11382]={s=750},  -- Blood of the Mountain
	[11384]={s=70},  -- Broken Basilisk Teeth
	[11385]={s=145},  -- Basilisk Scale
	[11386]={s=676},  -- Squishy Basilisk Eye
	[11387]={s=1013},  -- Basilisk Heart
	[11388]={s=1563},  -- Basilisk Venom
	[11389]={s=2163},  -- Shimmering Basilisk Skin
	[11390]={s=80},  -- Broken Bat Fang
	[11391]={s=205},  -- Spined Bat Wing
	[11392]={s=403},  -- Severed Bat Claw
	[11393]={s=780},  -- Small Bat Skull
	[11394]={s=580},  -- Bat Heart
	[11395]={s=830},  -- Bat Ear
	[11402]={s=1205},  -- Sleek Bat Pelt
	[11403]={s=1592},  -- Large Bat Fang
	[11404]={s=2080},  -- Evil Bat Eye
	[11405]={s=0},  -- Giant Silver Vein
	[11406]={s=168},  -- Rotting Bear Carcass
	[11407]={s=108},  -- Torn Bear Pelt
	[11408]={s=898},  -- Bear Jaw
	[11409]={s=503},  -- Bear Flank
	[11410]={s=578},  -- Savage Bear Claw
	[11411]={s=1484},  -- Large Bear Bone
	[11412]={s=0},  -- Nagmara's Vial
	[11413]={s=0},  -- Nagmara's Filled Vial
	[11414]={s=1828},  -- Grizzled Mane
	[11415]={s=200},  -- Mixed Berries
	[11416]={s=328},  -- Delicate Ribcage
	[11417]={s=1204},  -- Feathery Wing
	[11418]={s=604},  -- Hollow Wing Bone
	[11419]={s=1900},  -- Mysterious Unhatched Egg
	[11420]={s=1712},  -- Elegant Writing Tool
	[11422]={s=0},  -- Goblin Engineer's Renewal Gift
	[11423]={s=0},  -- Gnome Engineer's Renewal Gift
	[11444]={s=200},  -- Grim Guzzler Boar
	[11445]={s=0},  -- Flute of the Ancients
	[11446]={s=0},  -- A Crumpled Up Note
	[11462]={s=0},  -- Discarded Knife
	[11463]={s=0},  -- Undelivered Parcel
	[11464]={s=0},  -- Marshal Windsor's Lost Information
	[11465]={s=0},  -- Marshal Windsor's Lost Information
	[11466]={s=0},  -- Raschal's Report
	[11467]={s=0},  -- Blackrock Medallion
	[11468]={s=0},  -- Dark Iron Fanny Pack
	[11469]={s=3563},  -- Bloodband Bracers
	[11470]={s=0},  -- Tablet Transcript
	[11471]={s=0},  -- Fragile Sprite Darter Egg
	[11472]={s=0},  -- Silvermane Stalker Flank
	[11474]={s=500},  -- Sprite Darter Egg
	[11475]={s=7},  -- Wine-stained Cloak
	[11476]={s=0},  -- U'cha's Pelt
	[11477]={s=0},  -- White Ravasaur Claw
	[11478]={s=0},  -- Un'Goro Gorilla Pelt
	[11479]={s=0},  -- Un'Goro Stomper Pelt
	[11480]={s=0},  -- Un'Goro Thunderer Pelt
	[11482]={s=0},  -- Crystal Pylon User's Manual
	[11502]={s=6510},  -- Loreskin Shoulders
	[11503]={s=0},  -- Blood Amber
	[11504]={s=0},  -- Piece of Threshadon Carcass
	[11507]={s=0},  -- Spotted Hyena Pelt
	[11508]={s=1},  -- Gamemaster's Slippers
	[11509]={s=0},  -- Ravasaur Pheromone Gland
	[11510]={s=0},  -- Lar'korwi's Head
	[11511]={s=0},  -- Cenarion Beacon
	[11512]={s=0},  -- Patch of Tainted Skin
	[11513]={s=1},  -- Tainted Vitriol
	[11514]={s=1},  -- Fel Creep
	[11515]={s=1},  -- Corrupted Soul Shard
	[11516]={s=0},  -- Cenarion Plant Salve
	[11522]={s=0},  -- Silver Totem of Aquementas
	[11562]={s=1000},  -- Crystal Restore
	[11563]={s=1000},  -- Crystal Force
	[11564]={s=1000},  -- Crystal Ward
	[11565]={s=1000},  -- Crystal Yield
	[11566]={s=1000},  -- Crystal Charge
	[11567]={s=1000},  -- Crystal Spire
	[11568]={s=0},  -- Torwa's Pouch
	[11569]={s=0},  -- Preserved Threshadon Meat
	[11570]={s=0},  -- Preserved Pheromone Mixture
	[11582]={s=0},  -- Fel Salve
	[11583]={s=0},  -- Cactus Apple
	[11584]={s=1},  -- Cactus Apple Surprise
	[11590]={s=250},  -- Mechanical Repair Kit
	[11602]={s=0},  -- Grim Guzzler Key
	[11603]={s=30656},  -- Vilerend Slicer
	[11604]={s=19428},  -- Dark Iron Plate
	[11605]={s=10776},  -- Dark Iron Shoulders
	[11606]={s=19255},  -- Dark Iron Mail
	[11607]={s=51225},  -- Dark Iron Sunderer
	[11608]={s=45760},  -- Dark Iron Pulverizer
	[11610]={s=3000},  -- Plans: Dark Iron Pulverizer
	[11611]={s=3000},  -- Plans: Dark Iron Sunderer
	[11612]={s=3000},  -- Plans: Dark Iron Plate
	[11614]={s=3000},  -- Plans: Dark Iron Mail
	[11615]={s=3000},  -- Plans: Dark Iron Shoulders
	[11617]={s=0},  -- Eridan's Supplies
	[11622]={s=0},  -- Lesser Arcanum of Rumination
	[11623]={s=8333},  -- Spritecaster Cape
	[11624]={s=7566},  -- Kentic Amice
	[11625]={s=10452},  -- Enthralled Sphere
	[11626]={s=8081},  -- Blackveil Cape
	[11627]={s=12224},  -- Fleetfoot Greaves
	[11628]={s=24433},  -- Houndmaster's Bow
	[11629]={s=24527},  -- Houndmaster's Rifle
	[11630]={s=5},  -- Rockshard Pellets
	[11631]={s=16578},  -- Stoneshell Guard
	[11632]={s=7800},  -- Earthslag Shoulders
	[11633]={s=11730},  -- Spiderfang Carapace
	[11634]={s=5886},  -- Silkweb Gloves
	[11635]={s=35451},  -- Hookfang Shanker
	[11642]={s=0},  -- Lesser Arcanum of Constitution
	[11643]={s=0},  -- Lesser Arcanum of Tenacity
	[11644]={s=0},  -- Lesser Arcanum of Resilience
	[11645]={s=0},  -- Lesser Arcanum of Voracity
	[11646]={s=0},  -- Lesser Arcanum of Voracity
	[11647]={s=0},  -- Lesser Arcanum of Voracity
	[11648]={s=0},  -- Lesser Arcanum of Voracity
	[11649]={s=0},  -- Lesser Arcanum of Voracity
	[11662]={s=6218},  -- Ban'thok Sash
	[11665]={s=7110},  -- Ogreseer Fists
	[11668]={s=0},  -- Flute of Xavaric
	[11669]={s=17157},  -- Naglering
	[11674]={s=0},  -- Jadefire Felbind
	[11675]={s=12053},  -- Shadefiend Boots
	[11677]={s=9712},  -- Graverot Cape
	[11678]={s=15596},  -- Carapace of Anub'shiah
	[11679]={s=9781},  -- Rubicund Armguards
	[11682]={s=0},  -- Eridan's Vial
	[11684]={s=63086},  -- Ironfoe
	[11685]={s=11617},  -- Splinthide Shoulders
	[11686]={s=9329},  -- Girdle of Beastial Fury
	[11702]={s=30627},  -- Grizzle's Skinner
	[11703]={s=6148},  -- Stonewall Girdle
	[11722]={s=16610},  -- Dregmetal Spaulders
	[11723]={s=0},  -- Goodsteel's Balanced Flameberge
	[11724]={s=0},  -- Overdue Package
	[11725]={s=0},  -- Solid Crystal Leg Shaft
	[11726]={s=33533},  -- Savage Gladiator Chain
	[11727]={s=0},  -- Goodsteel Ledger
	[11728]={s=25336},  -- Savage Gladiator Leggings
	[11729]={s=19073},  -- Savage Gladiator Helm
	[11730]={s=12762},  -- Savage Gladiator Grips
	[11731]={s=19300},  -- Savage Gladiator Greaves
	[11732]={s=0},  -- Libram of Rumination
	[11733]={s=0},  -- Libram of Constitution
	[11734]={s=0},  -- Libram of Tenacity
	[11735]={s=16669},  -- Ragefury Eyepatch
	[11736]={s=0},  -- Libram of Resilience
	[11737]={s=0},  -- Libram of Voracity
	[11742]={s=8750},  -- Wayfarer's Knapsack
	[11743]={s=30734},  -- Rockfist
	[11744]={s=39242},  -- Bloodfist
	[11745]={s=6565},  -- Fists of Phalanx
	[11746]={s=11861},  -- Golem Skull Helm
	[11747]={s=16659},  -- Flamestrider Robes
	[11748]={s=25083},  -- Pyric Caduceus
	[11749]={s=20141},  -- Searingscale Leggings
	[11750]={s=43234},  -- Kindling Stave
	[11751]={s=0},  -- Burning Essence
	[11752]={s=0},  -- Black Blood of the Tormented
	[11753]={s=0},  -- Eye of Kajal
	[11754]={s=0},  -- Black Diamond
	[11755]={s=14627},  -- Verek's Collar
	[11764]={s=10398},  -- Cinderhide Armsplints
	[11765]={s=12525},  -- Pyremail Wristguards
	[11766]={s=8606},  -- Flameweave Cuffs
	[11767]={s=8637},  -- Emberplate Armguards
	[11768]={s=7224},  -- Incendic Bracers
	[11782]={s=12720},  -- Boreal Mantle
	[11783]={s=12767},  -- Chillsteel Girdle
	[11784]={s=33835},  -- Arbiter's Blade
	[11785]={s=29082},  -- Rock Golem Bulwark
	[11786]={s=50739},  -- Stone of the Earth
	[11787]={s=13732},  -- Shalehusk Boots
	[11802]={s=14980},  -- Lavacrest Leggings
	[11803]={s=41814},  -- Force of Magma
	[11804]={s=0},  -- Spraggle's Canteen
	[11805]={s=40439},  -- Rubidium Hammer
	[11807]={s=9153},  -- Sash of the Burning Heart
	[11808]={s=19292},  -- Circle of Flame
	[11809]={s=51287},  -- Flame Wrath
	[11810]={s=10000},  -- Force of Will
	[11811]={s=1500},  -- Smoking Heart of the Mountain
	[11812]={s=13979},  -- Cape of the Fire Salamander
	[11813]={s=3000},  -- Formula: Smoking Heart of the Mountain
	[11814]={s=13083},  -- Molten Fists
	[11815]={s=10000},  -- Hand of Justice
	[11816]={s=40735},  -- Angerforge's Battle Axe
	[11817]={s=39254},  -- Lord General's Sword
	[11818]={s=0},  -- Grimsite Outhouse Key
	[11819]={s=10000},  -- Second Wind
	[11820]={s=22301},  -- Royal Decorated Armor
	[11821]={s=22384},  -- Warstrife Leggings
	[11822]={s=11794},  -- Omnicast Boots
	[11823]={s=19730},  -- Luminary Kilt
	[11824]={s=13657},  -- Cyclopean Band
	[11825]={s=2500},  -- Pet Bombling
	[11826]={s=2500},  -- Lil' Smoky
	[11827]={s=675},  -- Schematic: Lil' Smoky
	[11829]={s=0},  -- Un'Goro Ash
	[11830]={s=0},  -- Webbed Diemetradon Scale
	[11831]={s=0},  -- Webbed Pterrordax Scale
	[11832]={s=10000},  -- Burst of Knowledge
	[11833]={s=0},  -- Gorishi Queen Lure
	[11834]={s=0},  -- Super Sticky Tar
	[11835]={s=0},  -- Gorishi Queen Brain
	[11837]={s=0},  -- Gorishi Scent Gland
	[11839]={s=11191},  -- Chief Architect's Monocle
	[11840]={s=7137},  -- Master Builder's Shirt
	[11841]={s=12527},  -- Senior Designer's Pantaloons
	[11842]={s=14208},  -- Lead Surveyor's Mantle
	[11843]={s=0},  -- Bank Voucher
	[11844]={s=0},  -- Pestlezugg's Un'Goro Report
	[11845]={s=62},  -- Handmade Leather Bag
	[11846]={s=30},  -- Wizbang's Special Brew
	[11847]={s=7},  -- Battered Cloak
	[11848]={s=5},  -- Flax Belt
	[11849]={s=7},  -- Rustmetal Bracers
	[11850]={s=7},  -- Short Duskbat Cape
	[11851]={s=12},  -- Scavenger Tunic
	[11852]={s=14},  -- Roamer's Leggings
	[11853]={s=388},  -- Rambling Boots
	[11854]={s=1494},  -- Samophlange Screwdriver
	[11855]={s=782},  -- Tork Wrench
	[11856]={s=15775},  -- Ceremonial Elven Blade
	[11857]={s=21377},  -- Sanctimonial Rod
	[11858]={s=4768},  -- Battlehard Cape
	[11859]={s=7135},  -- Jademoon Orb
	[11860]={s=12970},  -- Charged Lightning Rod
	[11861]={s=5207},  -- Girdle of Reprisal
	[11862]={s=7042},  -- White Bone Band
	[11863]={s=27191},  -- White Bone Shredder
	[11864]={s=34108},  -- White Bone Spear
	[11865]={s=8708},  -- Rancor Boots
	[11866]={s=9819},  -- Nagmara's Whipping Belt
	[11867]={s=8769},  -- Maddening Gauntlets
	[11868]={s=6542},  -- Choking Band
	[11869]={s=6542},  -- Sha'ni's Ring
	[11870]={s=10287},  -- Oblivion Orb
	[11871]={s=10666},  -- Snarkshaw Spaulders
	[11872]={s=8566},  -- Eschewal Greaves
	[11873]={s=9661},  -- Ethereal Mist Cape
	[11874]={s=12124},  -- Clouddrift Mantle
	[11875]={s=5776},  -- Breezecloud Bracers
	[11876]={s=16287},  -- Plainstalker Tunic
	[11882]={s=20520},  -- Outrider Leggings
	[11883]={s=0},  -- A Dingy Fanny Pack
	[11884]={s=1846},  -- Moonlit Amice
	[11885]={s=711},  -- Shadowforge Torch
	[11886]={s=0},  -- Urgent Message
	[11887]={s=12},  -- Cenarion Circle Cache
	[11888]={s=4879},  -- Quintis' Research Gloves
	[11889]={s=7345},  -- Bark Iron Pauldrons
	[11902]={s=34194},  -- Linken's Sword of Mastery
	[11904]={s=13815},  -- Spirit of Aquementas
	[11905]={s=6203},  -- Linken's Boomerang
	[11906]={s=32723},  -- Beastsmasher
	[11907]={s=41050},  -- Beastslayer
	[11908]={s=9886},  -- Archaeologist's Quarry Boots
	[11909]={s=8267},  -- Excavator's Utility Belt
	[11910]={s=12345},  -- Bejeweled Legguards
	[11911]={s=12392},  -- Treetop Leggings
	[11912]={s=0},  -- Package of Empty Ooze Containers
	[11913]={s=14044},  -- Clayridge Helm
	[11914]={s=0},  -- Empty Cursed Ooze Jar
	[11915]={s=20124},  -- Shizzle's Drizzle Blocker
	[11916]={s=11834},  -- Shizzle's Muzzle
	[11917]={s=6334},  -- Shizzle's Nozzle Wiper
	[11918]={s=9537},  -- Grotslab Gloves
	[11919]={s=9572},  -- Cragplate Greaves
	[11920]={s=40732},  -- Wraith Scythe
	[11921]={s=54167},  -- Impervious Giant
	[11922]={s=43491},  -- Blood-etched Blade
	[11923]={s=43648},  -- The Hammer of Grace
	[11924]={s=20475},  -- Robes of the Royal Crown
	[11925]={s=16484},  -- Ghostshroud
	[11926]={s=24590},  -- Deathdealer Breastplate
	[11927]={s=16456},  -- Legplates of the Eternal Guardian
	[11928]={s=22045},  -- Thaurissan's Royal Scepter
	[11929]={s=16581},  -- Haunting Specter Leggings
	[11930]={s=14588},  -- The Emperor's New Cape
	[11931]={s=58103},  -- Dreadforge Retaliator
	[11932]={s=58322},  -- Guiding Stave of Wisdom
	[11933]={s=19646},  -- Imperial Jewel
	[11934]={s=19921},  -- Emperor's Seal
	[11935]={s=13162},  -- Magmus Stone
	[11936]={s=284},  -- Relic Hunter Belt
	[11937]={s=187},  -- Fat Sack of Coins
	[11938]={s=213},  -- Sack of Gems
	[11939]={s=671},  -- Shiny Bracelet
	[11940]={s=389},  -- Sparkly Necklace
	[11941]={s=5896},  -- False Documents
	[11942]={s=5303},  -- Legal Documents
	[11943]={s=21485},  -- Deed to Thandol Span
	[11944]={s=8821},  -- Dark Iron Baby Booties
	[11945]={s=6592},  -- Dark Iron Ring
	[11946]={s=7912},  -- Fire Opal Necklace
	[11947]={s=0},  -- Filled Cursed Ooze Jar
	[11948]={s=0},  -- Empty Tainted Ooze Jar
	[11949]={s=0},  -- Filled Tainted Ooze Jar
	[11950]={s=0},  -- Windblossom Berries
	[11951]={s=0},  -- Whipper Root Tuber
	[11952]={s=0},  -- Night Dragon's Breath
	[11953]={s=0},  -- Empty Pure Sample Jar
	[11954]={s=0},  -- Filled Pure Sample Jar
	[11955]={s=0},  -- Bag of Empty Ooze Containers
	[11962]={s=7939},  -- Manacle Cuffs
	[11963]={s=10025},  -- Penance Spaulders
	[11964]={s=30156},  -- Swiftstrike Cudgel
	[11965]={s=464},  -- Quartz Ring
	[11966]={s=164},  -- Small Sack of Coins
	[11967]={s=1087},  -- Zircon Band
	[11968]={s=997},  -- Amber Hoop
	[11969]={s=1721},  -- Jacinth Circle
	[11970]={s=1710},  -- Spinel Ring
	[11971]={s=3969},  -- Amethyst Band
	[11972]={s=4649},  -- Carnelian Loop
	[11973]={s=3971},  -- Hematite Link
	[11974]={s=4971},  -- Aquamarine Ring
	[11975]={s=4739},  -- Topaz Ring
	[11976]={s=7778},  -- Sardonyx Knuckle
	[11977]={s=7896},  -- Serpentine Loop
	[11978]={s=7414},  -- Jasper Link
	[11979]={s=7471},  -- Perdiot Circle
	[11980]={s=10539},  -- Opal Ring
	[11981]={s=496},  -- Lead Band
	[11982]={s=1062},  -- Viridian Band
	[11983]={s=1130},  -- Chrome Ring
	[11984]={s=2189},  -- Cobalt Ring
	[11985]={s=2144},  -- Cerulean Ring
	[11986]={s=1745},  -- Thallium Hoop
	[11987]={s=2885},  -- Iridium Circle
	[11988]={s=7113},  -- Tellurium Band
	[11989]={s=7471},  -- Vanadium Loop
	[11990]={s=8306},  -- Selenium Loop
	[11991]={s=6317},  -- Quicksilver Ring
	[11992]={s=7396},  -- Vermilion Band
	[11993]={s=874},  -- Clay Ring
	[11994]={s=1312},  -- Coral Band
	[11995]={s=914},  -- Ivory Band
	[11996]={s=1713},  -- Basalt Ring
	[11997]={s=6469},  -- Greenstone Circle
	[11998]={s=2896},  -- Jet Loop
	[11999]={s=5538},  -- Lodestone Hoop
	[12000]={s=41053},  -- Limb Cleaver
	[12001]={s=4971},  -- Onyx Ring
	[12002]={s=6322},  -- Marble Circle
	[12003]={s=250},  -- Dark Dwarven Lager
	[12004]={s=9163},  -- Obsidian Band
	[12005]={s=8813},  -- Granite Ring
	[12006]={s=1064},  -- Meadow Ring
	[12007]={s=1064},  -- Prairie Ring
	[12008]={s=895},  -- Savannah Ring
	[12009]={s=2174},  -- Tundra Ring
	[12010]={s=2469},  -- Fen Ring
	[12011]={s=4649},  -- Forest Hoop
	[12012]={s=2463},  -- Marsh Ring
	[12013]={s=4649},  -- Desert Ring
	[12014]={s=6289},  -- Arctic Ring
	[12015]={s=8811},  -- Swamp Ring
	[12016]={s=7781},  -- Jungle Ring
	[12017]={s=8963},  -- Prismatic Band
	[12018]={s=13842},  -- Conservator Helm
	[12019]={s=4220},  -- Cerulean Talisman
	[12020]={s=3969},  -- Thallium Choker
	[12021]={s=9327},  -- Shieldplate Sabatons
	[12022]={s=4718},  -- Iridium Chain
	[12023]={s=4971},  -- Tellurium Necklace
	[12024]={s=5396},  -- Vanadium Talisman
	[12025]={s=5282},  -- Selenium Chain
	[12026]={s=7757},  -- Quicksilver Pendant
	[12027]={s=6257},  -- Vermilion Necklace
	[12028]={s=4007},  -- Basalt Necklace
	[12029]={s=5395},  -- Greenstone Talisman
	[12030]={s=7143},  -- Jet Chain
	[12031]={s=7894},  -- Lodestone Necklace
	[12032]={s=5396},  -- Onyx Choker
	[12033]={s=0},  -- Thaurissan Family Jewels
	[12034]={s=5012},  -- Marble Necklace
	[12035]={s=5513},  -- Obsidian Pendant
	[12036]={s=5982},  -- Granite Necklace
	[12037]={s=87},  -- Mystery Meat
	[12038]={s=9092},  -- Lagrave's Seal
	[12039]={s=4224},  -- Tundra Necklace
	[12040]={s=4164},  -- Forest Pendant
	[12041]={s=14446},  -- Windshear Leggings
	[12042]={s=4749},  -- Marsh Chain
	[12043]={s=5396},  -- Desert Choker
	[12044]={s=5145},  -- Arctic Pendant
	[12045]={s=7767},  -- Swamp Pendant
	[12046]={s=5757},  -- Jungle Necklace
	[12047]={s=4996},  -- Spectral Necklace
	[12048]={s=6507},  -- Prismatic Pendant
	[12049]={s=16850},  -- Splintsteel Armor
	[12050]={s=8963},  -- Hazecover Boots
	[12051]={s=8996},  -- Brazen Gauntlets
	[12052]={s=837},  -- Ring of the Moon
	[12053]={s=837},  -- Volcanic Rock Ring
	[12054]={s=837},  -- Demon Band
	[12055]={s=8375},  -- Stardust Band
	[12056]={s=8375},  -- Ring of the Heavens
	[12057]={s=8375},  -- Dragonscale Band
	[12058]={s=8376},  -- Demonic Bone Ring
	[12059]={s=12377},  -- Conqueror's Medallion
	[12060]={s=0},  -- Shindrell's Note
	[12061]={s=40212},  -- Blade of Reckoning
	[12062]={s=40365},  -- Skilled Fighting Blade
	[12064]={s=1},  -- Gamemaster Hood
	[12065]={s=7953},  -- Ward of the Elements
	[12066]={s=11149},  -- Shaleskin Cape
	[12082]={s=13726},  -- Wyrmhide Spaulders
	[12083]={s=7348},  -- Valconian Sash
	[12102]={s=9042},  -- Ring of the Aristocrat
	[12103]={s=12157},  -- Star of Mystaria
	[12108]={s=23054},  -- Basaltscale Armor
	[12109]={s=11569},  -- Azure Moon Amice
	[12110]={s=11610},  -- Raincaster Drape
	[12111]={s=7768},  -- Lavaplate Gauntlets
	[12112]={s=10406},  -- Crypt Demon Bracers
	[12113]={s=10443},  -- Sunborne Cape
	[12114]={s=8734},  -- Nightfall Gloves
	[12115]={s=7012},  -- Stalwart Clutch
	[12122]={s=0},  -- Kum'isha's Junk
	[12144]={s=0},  -- Eggscilloscope
	[12162]={s=750},  -- Plans: Hardened Iron Shortsword
	[12163]={s=1100},  -- Plans: Moonsteel Broadsword
	[12164]={s=1100},  -- Plans: Massive Iron Axe
	[12184]={s=87},  -- Raptor Flesh
	[12185]={s=12895},  -- Bloodsail Admiral's Hat
	[12190]={s=250},  -- Dreamless Sleep Potion
	[12191]={s=0},  -- Silver Dawning's Lockbox
	[12192]={s=0},  -- Mist Veil's Lockbox
	[12202]={s=87},  -- Tiger Meat
	[12203]={s=87},  -- Red Wolf Meat
	[12204]={s=112},  -- Heavy Kodo Meat
	[12205]={s=112},  -- White Spider Meat
	[12206]={s=112},  -- Tender Crab Meat
	[12207]={s=150},  -- Giant Egg
	[12208]={s=150},  -- Tender Wolf Meat
	[12209]={s=95},  -- Lean Wolf Steak
	[12210]={s=300},  -- Roast Raptor
	[12212]={s=300},  -- Jungle Stew
	[12213]={s=300},  -- Carrion Surprise
	[12214]={s=300},  -- Mystery Stew
	[12215]={s=300},  -- Heavy Kodo Stew
	[12216]={s=300},  -- Spiced Chili Crab
	[12217]={s=300},  -- Dragonbreath Chili
	[12218]={s=300},  -- Monster Omelet
	[12219]={s=0},  -- Unadorned Seal of Ascension
	[12220]={s=0},  -- Intact Elemental Bracer
	[12223]={s=4},  -- Meaty Bat Wing
	[12224]={s=10},  -- Crispy Bat Wing
	[12225]={s=187},  -- Blump Family Fishing Pole
	[12226]={s=6},  -- Recipe: Crispy Bat Wing
	[12227]={s=400},  -- Recipe: Lean Wolf Steak
	[12228]={s=1250},  -- Recipe: Roast Raptor
	[12229]={s=1250},  -- Recipe: Hot Wolf Ribs
	[12230]={s=0},  -- Felwood Slime Sample
	[12231]={s=750},  -- Recipe: Jungle Stew
	[12232]={s=1250},  -- Recipe: Carrion Surprise
	[12233]={s=750},  -- Recipe: Mystery Stew
	[12234]={s=0},  -- Corrupted Felwood Sample
	[12235]={s=0},  -- Un'Goro Slime Sample
	[12236]={s=0},  -- Pure Un'Goro Sample
	[12237]={s=0},  -- Fine Crab Chunks
	[12238]={s=2},  -- Darkshore Grouper
	[12239]={s=1750},  -- Recipe: Dragonbreath Chili
	[12240]={s=1750},  -- Recipe: Heavy Kodo Stew
	[12241]={s=0},  -- Collected Dragon Egg
	[12242]={s=0},  -- Sea Creature Bones
	[12243]={s=45980},  -- Smoldering Claw
	[12247]={s=5674},  -- Broad Bladed Knife
	[12248]={s=6405},  -- Daring Dirk
	[12249]={s=6039},  -- Merciless Axe
	[12250]={s=8068},  -- Midnight Axe
	[12251]={s=10779},  -- Big Stick
	[12252]={s=12619},  -- Staff of Protection
	[12253]={s=3545},  -- Brilliant Red Cloak
	[12254]={s=4483},  -- Well Oiled Cloak
	[12255]={s=6997},  -- Pale Leggings
	[12256]={s=8765},  -- Cindercloth Leggings
	[12257]={s=3885},  -- Heavy Notched Belt
	[12259]={s=8072},  -- Glinting Steel Dagger
	[12260]={s=10395},  -- Searing Golden Blade
	[12261]={s=950},  -- Plans: Searing Golden Blade
	[12262]={s=0},  -- Empty Worg Pup Cage
	[12263]={s=0},  -- Caged Worg Pup
	[12264]={s=1500},  -- Worg Carrier
	[12282]={s=8},  -- Worn Battleaxe
	[12283]={s=0},  -- Broodling Essence
	[12284]={s=0},  -- Draco-Incarcinatrix 900
	[12286]={s=0},  -- Eggscilloscope Prototype
	[12287]={s=0},  -- Collectronic Module
	[12288]={s=0},  -- Encased Corrupt Ooze
	[12289]={s=0},  -- Sea Turtle Remains
	[12291]={s=0},  -- Merged Ooze Sample
	[12292]={s=0},  -- Strangely Marked Box
	[12293]={s=0},  -- Fine Gold Thread
	[12295]={s=282},  -- Leggings of the People's Militia
	[12296]={s=722},  -- Spark of the People's Militia
	[12299]={s=16},  -- Netted Gloves
	[12300]={s=0},  -- Orb of Draconic Energy
	[12301]={s=0},  -- Bamboo Cage Key
	[12302]={s=0},  -- Reins of the Frostsaber
	[12303]={s=0},  -- Reins of the Nightsaber
	[12323]={s=0},  -- Unforged Seal of Ascension
	[12324]={s=0},  -- Forged Seal of Ascension
	[12330]={s=0},  -- Horn of the Red Wolf
	[12334]={s=0},  -- Frostmaul Shards
	[12335]={s=0},  -- Gemstone of Smolderthorn
	[12336]={s=0},  -- Gemstone of Spirestone
	[12337]={s=0},  -- Gemstone of Bloodaxe
	[12339]={s=0},  -- Vaelan's Gift
	[12341]={s=0},  -- Blackwood Fruit Sample
	[12342]={s=0},  -- Blackwood Grain Sample
	[12343]={s=0},  -- Blackwood Nut Sample
	[12344]={s=0},  -- Seal of Ascension
	[12345]={s=0},  -- Bijou's Belongings
	[12346]={s=0},  -- Empty Cleansing Bowl
	[12347]={s=0},  -- Filled Cleansing Bowl
	[12349]={s=0},  -- Cliffspring River Sample
	[12350]={s=0},  -- Empty Sampling Tube
	[12351]={s=0},  -- Horn of the Arctic Wolf
	[12352]={s=0},  -- Doomrigger's Clasp
	[12353]={s=0},  -- White Stallion Bridle
	[12354]={s=0},  -- Palomino Bridle
	[12355]={s=0},  -- Talisman of Corruption
	[12356]={s=0},  -- Highperch Wyvern Egg
	[12358]={s=0},  -- Darkstone Tablet
	[12359]={s=600},  -- Thorium Bar
	[12360]={s=5000},  -- Arcanite Bar
	[12361]={s=7000},  -- Blue Sapphire
	[12363]={s=2000},  -- Arcane Crystal
	[12364]={s=10000},  -- Huge Emerald
	[12365]={s=250},  -- Dense Stone
	[12366]={s=0},  -- Thick Yeti Fur
	[12367]={s=0},  -- Pristine Yeti Horn
	[12368]={s=0},  -- Dawn's Gambit
	[12382]={s=0},  -- Key to the City
	[12383]={s=0},  -- Moontouched Feather
	[12384]={s=0},  -- Cache of Mau'ari
	[12402]={s=0},  -- Ancient Egg
	[12404]={s=75},  -- Dense Sharpening Stone
	[12405]={s=9239},  -- Thorium Armor
	[12406]={s=4636},  -- Thorium Belt
	[12408]={s=4998},  -- Thorium Bracers
	[12409]={s=10336},  -- Thorium Boots
	[12410]={s=10372},  -- Thorium Helm
	[12411]={s=0},  -- Third Mosh'aru Tablet
	[12412]={s=0},  -- Fourth Mosh'aru Tablet
	[12414]={s=17376},  -- Thorium Leggings
	[12415]={s=17003},  -- Radiant Breastplate
	[12416]={s=7595},  -- Radiant Belt
	[12417]={s=17034},  -- Radiant Circlet
	[12418]={s=10242},  -- Radiant Gloves
	[12419]={s=16421},  -- Radiant Boots
	[12420]={s=25330},  -- Radiant Leggings
	[12422]={s=16204},  -- Imperial Plate Chest
	[12424]={s=5533},  -- Imperial Plate Belt
	[12425]={s=6044},  -- Imperial Plate Bracers
	[12426]={s=12062},  -- Imperial Plate Boots
	[12427]={s=12106},  -- Imperial Plate Helm
	[12428]={s=8646},  -- Imperial Plate Shoulders
	[12429]={s=17923},  -- Imperial Plate Leggings
	[12430]={s=0},  -- Frostsaber E'ko
	[12431]={s=0},  -- Winterfall E'ko
	[12432]={s=0},  -- Shardtooth E'ko
	[12433]={s=0},  -- Wildkin E'ko
	[12434]={s=0},  -- Chillwind E'ko
	[12435]={s=0},  -- Ice Thistle E'ko
	[12436]={s=0},  -- Frostmaul E'ko
	[12437]={s=0},  -- Ridgewell's Crate
	[12438]={s=0},  -- Tinkee's Letter
	[12444]={s=0},  -- Uncracked Chillwind Horn
	[12445]={s=0},  -- Felnok's Package
	[12446]={s=19},  -- Anvilmar Musket
	[12447]={s=19},  -- Thistlewood Bow
	[12448]={s=19},  -- Light Hunting Rifle
	[12449]={s=19},  -- Primitive Bow
	[12450]={s=1500},  -- Juju Flurry
	[12451]={s=1500},  -- Juju Power
	[12455]={s=1500},  -- Juju Ember
	[12457]={s=1500},  -- Juju Chill
	[12458]={s=1500},  -- Juju Guile
	[12459]={s=1500},  -- Juju Escape
	[12460]={s=1500},  -- Juju Might
	[12462]={s=20274},  -- Embrace of the Wind Serpent
	[12463]={s=42446},  -- Drakefang Butcher
	[12464]={s=8520},  -- Bloodfire Talons
	[12465]={s=10261},  -- Nightfall Drape
	[12466]={s=6865},  -- Dawnspire Cord
	[12467]={s=0},  -- Alien Egg
	[12470]={s=8784},  -- Sandstalker Ankleguards
	[12472]={s=0},  -- Krakle's Thermometer
	[12522]={s=182},  -- Bingles' Flying Gloves
	[12524]={s=0},  -- Blue-feathered Amulet
	[12525]={s=0},  -- Jaron's Supplies
	[12527]={s=35332},  -- Ribsplitter
	[12528]={s=37833},  -- The Judge's Gavel
	[12529]={s=1500},  -- Smolderweb Carrier
	[12530]={s=0},  -- Spire Spider Egg
	[12531]={s=28883},  -- Searing Needle
	[12532]={s=48501},  -- Spire of the Stoneshaper
	[12533]={s=0},  -- Roughshod Pike
	[12534]={s=0},  -- Omokk's Head
	[12535]={s=34925},  -- Doomforged Straightedge
	[12542]={s=12356},  -- Funeral Pyre Vestment
	[12543]={s=7156},  -- Songstone of Ironforge
	[12544]={s=7407},  -- Thrall's Resolve
	[12545]={s=7082},  -- Eye of Orgrimmar
	[12546]={s=7463},  -- Aristocratic Cuffs
	[12547]={s=10519},  -- Mar Alom's Grip
	[12548]={s=7102},  -- Magni's Will
	[12549]={s=13669},  -- Braincage
	[12550]={s=6464},  -- Runed Golem Shackles
	[12551]={s=11594},  -- Stoneshield Cloak
	[12552]={s=10980},  -- Blisterbane Wrap
	[12553]={s=17699},  -- Swiftwalker Boots
	[12554]={s=9474},  -- Hands of the Exalted Herald
	[12555]={s=11406},  -- Battlechaser's Greaves
	[12556]={s=14317},  -- High Priestess Boots
	[12557]={s=14368},  -- Ebonsteel Spaulders
	[12558]={s=0},  -- Blue-feathered Necklace
	[12562]={s=0},  -- Important Blackrock Documents
	[12563]={s=0},  -- Warlord Goretooth's Command
	[12564]={s=0},  -- Assassination Note
	[12565]={s=0},  -- Winna's Kitten Carrier
	[12566]={s=0},  -- Hardened Flasket
	[12567]={s=0},  -- Filled Flasket
	[12582]={s=51199},  -- Keris of Zul'Serak
	[12583]={s=74346},  -- Blackhand Doomsaw
	[12584]={s=30472},  -- Grand Marshal's Longsword
	[12586]={s=0},  -- Immature Venom Sac
	[12587]={s=21031},  -- Eye of Rend
	[12588]={s=25446},  -- Bonespike Shoulder
	[12589]={s=10251},  -- Dustfeather Sash
	[12590]={s=75624},  -- Felstriker
	[12592]={s=95241},  -- Blackblade of Shahram
	[12602]={s=35212},  -- Draconian Deflector
	[12603]={s=25048},  -- Nightbrace Tunic
	[12604]={s=14368},  -- Starfire Tiara
	[12605]={s=29106},  -- Serpentine Skuller
	[12606]={s=12668},  -- Crystallized Girdle
	[12607]={s=8048},  -- Brilliant Chromatic Scale
	[12608]={s=11026},  -- Butcher's Apron
	[12609]={s=20498},  -- Polychromatic Visionwrap
	[12610]={s=12247},  -- Runic Plate Shoulders
	[12611]={s=12293},  -- Runic Plate Boots
	[12612]={s=12956},  -- Runic Plate Helm
	[12613]={s=18205},  -- Runic Breastplate
	[12614]={s=18272},  -- Runic Plate Leggings
	[12618]={s=23972},  -- Enchanted Thorium Breastplate
	[12619]={s=24058},  -- Enchanted Thorium Leggings
	[12620]={s=17245},  -- Enchanted Thorium Helm
	[12621]={s=45085},  -- Demonfork
	[12622]={s=0},  -- Shardtooth Meat
	[12623]={s=0},  -- Chillwind Meat
	[12624]={s=20642},  -- Wildthorn Mail
	[12626]={s=9191},  -- Funeral Cuffs
	[12627]={s=0},  -- Temporal Displacer
	[12628]={s=16640},  -- Demon Forged Breastplate
	[12630]={s=0},  -- Head of Rend Blackhand
	[12631]={s=8919},  -- Fiery Plate Gauntlets
	[12632]={s=14099},  -- Storm Gauntlets
	[12633]={s=14859},  -- Whitesoul Helm
	[12634]={s=15310},  -- Chiselbrand Girdle
	[12635]={s=0},  -- Simple Parchment
	[12636]={s=24285},  -- Helm of the Great Chief
	[12637]={s=10316},  -- Backusarian Gauntlets
	[12638]={s=0},  -- Andorhal Watch
	[12639]={s=15271},  -- Stronghold Gauntlets
	[12640]={s=21894},  -- Lionheart Helm
	[12641]={s=43836},  -- Invulnerable Mail
	[12642]={s=0},  -- Cleansed Infernal Orb
	[12643]={s=75},  -- Dense Weightstone
	[12644]={s=200},  -- Dense Grinding Stone
	[12645]={s=500},  -- Thorium Shield Spike
	[12646]={s=0},  -- Infus Emerald
	[12647]={s=0},  -- Felhas Ruby
	[12648]={s=0},  -- Imprisoned Felhound Spirit
	[12649]={s=0},  -- Imprisoned Infernal Spirit
	[12650]={s=0},  -- Attuned Dampener
	[12651]={s=36055},  -- Blackcrow
	[12652]={s=0},  -- Bijou's Reconnaissance Report
	[12653]={s=36318},  -- Riphook
	[12654]={s=62},  -- Doomshot
	[12655]={s=500},  -- Enchanted Thorium Bar
	[12662]={s=600},  -- Demonic Rune
	[12663]={s=0},  -- Glyphed Oaken Branch
	[12682]={s=3000},  -- Plans: Thorium Armor
	[12683]={s=3000},  -- Plans: Thorium Belt
	[12684]={s=3000},  -- Plans: Thorium Bracers
	[12685]={s=3000},  -- Plans: Radiant Belt
	[12687]={s=3000},  -- Plans: Imperial Plate Shoulders
	[12688]={s=3000},  -- Plans: Imperial Plate Belt
	[12689]={s=3500},  -- Plans: Radiant Breastplate
	[12690]={s=3000},  -- Plans: Imperial Plate Bracers
	[12691]={s=4000},  -- Plans: Wildthorn Mail
	[12692]={s=4000},  -- Plans: Thorium Shield Spike
	[12693]={s=5000},  -- Plans: Thorium Boots
	[12694]={s=5000},  -- Plans: Thorium Helm
	[12695]={s=5000},  -- Plans: Radiant Gloves
	[12696]={s=5000},  -- Plans: Demon Forged Breastplate
	[12697]={s=5500},  -- Plans: Radiant Boots
	[12699]={s=5000},  -- Plans: Fiery Plate Gauntlets
	[12700]={s=6250},  -- Plans: Imperial Plate Boots
	[12701]={s=6250},  -- Plans: Imperial Plate Helm
	[12702]={s=6250},  -- Plans: Radiant Circlet
	[12703]={s=10000},  -- Plans: Storm Gauntlets
	[12704]={s=7500},  -- Plans: Thorium Leggings
	[12705]={s=7500},  -- Plans: Imperial Plate Chest
	[12707]={s=7500},  -- Plans: Runic Plate Boots
	[12708]={s=0},  -- Crossroads' Supply Crates
	[12709]={s=57991},  -- Finkle's Skinner
	[12710]={s=0},  -- Glowing Hunk of the Beast's Flesh
	[12711]={s=10000},  -- Plans: Whitesoul Helm
	[12712]={s=0},  -- Warosh's Mojo
	[12713]={s=10000},  -- Plans: Radiant Leggings
	[12715]={s=10000},  -- Plans: Imperial Plate Leggings
	[12716]={s=15000},  -- Plans: Helm of the Great Chief
	[12717]={s=15000},  -- Plans: Lionheart Helm
	[12718]={s=15000},  -- Plans: Runic Breastplate
	[12719]={s=15000},  -- Plans: Runic Plate Leggings
	[12721]={s=0},  -- Good Luck Half-Charm
	[12722]={s=0},  -- Good Luck Other-Half-Charm
	[12723]={s=0},  -- Good Luck Charm
	[12724]={s=0},  -- Janice's Parcel
	[12725]={s=15000},  -- Plans: Enchanted Thorium Helm
	[12726]={s=15000},  -- Plans: Enchanted Thorium Leggings
	[12727]={s=15000},  -- Plans: Enchanted Thorium Breastplate
	[12728]={s=20000},  -- Plans: Invulnerable Mail
	[12730]={s=0},  -- Warosh's Scroll
	[12731]={s=0},  -- Pristine Hide of the Beast
	[12732]={s=0},  -- Incendia Agave
	[12733]={s=0},  -- Sacred Frostsaber Meat
	[12734]={s=0},  -- Enchanted Scarlet Thread
	[12735]={s=0},  -- Frayed Abomination Stitching
	[12736]={s=0},  -- Frostwhisper's Embalming Fluid
	[12737]={s=0},  -- Gloom Weed
	[12738]={s=0},  -- Dalson Outhouse Key
	[12739]={s=0},  -- Dalson Cabinet Key
	[12740]={s=0},  -- Fifth Mosh'aru Tablet
	[12741]={s=0},  -- Sixth Mosh'aru Tablet
	[12752]={s=22907},  -- Cap of the Scarlet Savant
	[12753]={s=0},  -- Skin of Shadow
	[12756]={s=35057},  -- Leggings of Arcana
	[12757]={s=35192},  -- Breastplate of Bloodthirst
	[12765]={s=0},  -- Secret Note #1
	[12766]={s=0},  -- Secret Note #2
	[12768]={s=0},  -- Secret Note #3
	[12770]={s=0},  -- Bijou's Information
	[12771]={s=0},  -- Empty Firewater Flask
	[12773]={s=33079},  -- Ornate Thorium Handaxe
	[12774]={s=36044},  -- Dawn's Edge
	[12775]={s=39949},  -- Huge Thorium Battleaxe
	[12776]={s=48124},  -- Enchanted Battlehammer
	[12777]={s=38648},  -- Blazing Rapier
	[12780]={s=0},  -- General Drakkisath's Command
	[12781]={s=42721},  -- Serenity
	[12782]={s=56808},  -- Corruption
	[12783]={s=58215},  -- Heartseeker
	[12784]={s=73036},  -- Arcanite Reaper
	[12785]={s=0},  -- Incendia Powder
	[12790]={s=74619},  -- Arcanite Champion
	[12791]={s=39411},  -- Barman Shanker
	[12792]={s=39255},  -- Volcanic Hammer
	[12793]={s=16538},  -- Mixologist's Tunic
	[12794]={s=56304},  -- Masterwork Stormhammer
	[12796]={s=70912},  -- Hammer of the Titans
	[12797]={s=56943},  -- Frostguard
	[12798]={s=57150},  -- Annihilator
	[12799]={s=7000},  -- Large Opal
	[12800]={s=10000},  -- Azerothian Diamond
	[12803]={s=500},  -- Living Essence
	[12804]={s=2000},  -- Powerful Mojo
	[12806]={s=0},  -- Unforged Rune Covered Breastplate
	[12807]={s=0},  -- Scourge Banner
	[12808]={s=1000},  -- Essence of Undeath
	[12809]={s=10000},  -- Guardian Stone
	[12810]={s=500},  -- Enchanted Leather
	[12811]={s=20000},  -- Righteous Orb
	[12812]={s=0},  -- Unfired Plate Gauntlets
	[12813]={s=0},  -- Flask of Mystery Goo
	[12814]={s=0},  -- Flame in a Bottle
	[12815]={s=0},  -- Beacon Torch
	[12819]={s=4000},  -- Plans: Ornate Thorium Handaxe
	[12820]={s=0},  -- Winterfall Firewater
	[12821]={s=4000},  -- Plans: Dawn's Edge
	[12822]={s=0},  -- Toxic Horror Droplet
	[12823]={s=5000},  -- Plans: Huge Thorium Battleaxe
	[12824]={s=5000},  -- Plans: Enchanted Battlehammer
	[12825]={s=5000},  -- Plans: Blazing Rapier
	[12827]={s=5000},  -- Plans: Serenity
	[12828]={s=5500},  -- Plans: Volcanic Hammer
	[12829]={s=0},  -- Winterfall Crate
	[12830]={s=5500},  -- Plans: Corruption
	[12833]={s=20000},  -- Plans: Hammer of the Titans
	[12834]={s=20000},  -- Plans: Arcanite Champion
	[12835]={s=20000},  -- Plans: Annihilator
	[12836]={s=20000},  -- Plans: Frostguard
	[12837]={s=20000},  -- Plans: Masterwork Stormhammer
	[12838]={s=20000},  -- Plans: Arcanite Reaper
	[12839]={s=20000},  -- Plans: Heartseeker
	[12840]={s=0},  -- Minion's Scourgestone
	[12841]={s=0},  -- Invader's Scourgestone
	[12842]={s=0},  -- Crudely-written Log
	[12843]={s=0},  -- Corruptor's Scourgestone
	[12844]={s=0},  -- Argent Dawn Valor Token
	[12845]={s=0},  -- Medallion of Faith
	[12846]={s=0},  -- Argent Dawn Commission
	[12847]={s=0},  -- Soul Stained Pike
	[12848]={s=0},  -- Blood Stained Pike
	[12849]={s=0},  -- Demon Kissed Sack
	[12871]={s=8048},  -- Chromatic Carapace
	[12884]={s=0},  -- Arnak's Hoof
	[12885]={s=0},  -- Pamela's Doll
	[12886]={s=0},  -- Pamela's Doll's Head
	[12887]={s=0},  -- Pamela's Doll's Left Side
	[12888]={s=0},  -- Pamela's Doll's Right Side
	[12891]={s=0},  -- Jaron's Pick
	[12894]={s=0},  -- Joseph's Wedding Ring
	[12895]={s=29461},  -- Breastplate of the Chromatic Flight
	[12896]={s=0},  -- First Relic Fragment
	[12897]={s=0},  -- Second Relic Fragment
	[12898]={s=0},  -- Third Relic Fragment
	[12899]={s=0},  -- Fourth Relic Fragment
	[12900]={s=0},  -- Annals of Darrowshire
	[12903]={s=45482},  -- Legguards of the Chromatic Defier
	[12905]={s=13633},  -- Wildfire Cape
	[12906]={s=0},  -- Purified Moonwell Water
	[12907]={s=0},  -- Corrupt Moonwell Water
	[12922]={s=0},  -- Empty Canteen
	[12923]={s=0},  -- Awbee's Scale
	[12924]={s=0},  -- Ritual Candle
	[12925]={s=0},  -- Arikara Serpent Skin
	[12926]={s=14907},  -- Flaming Band
	[12927]={s=19149},  -- Truestrike Shoulders
	[12928]={s=0},  -- Umi's Mechanical Yeti
	[12929]={s=19646},  -- Emberfury Talisman
	[12930]={s=10000},  -- Briarwood Reed
	[12935]={s=23196},  -- Warmaster Legguards
	[12936]={s=11640},  -- Battleborn Armbraces
	[12938]={s=0},  -- Blood of Heroes
	[12939]={s=60363},  -- Dal'Rend's Tribal Guardian
	[12940]={s=54812},  -- Dal'Rend's Sacred Charge
	[12942]={s=0},  -- Panther Cage Key
	[12945]={s=42565},  -- Legplates of the Chromatic Defier
	[12946]={s=0},  -- Hypercapacitor Gizmo
	[12952]={s=14336},  -- Skull of Gyth
	[12953]={s=21584},  -- Dragoneye Coif
	[12954]={s=0},  -- Davil's Libram
	[12955]={s=0},  -- Redpath's Shield
	[12956]={s=0},  -- Skull of Horgus
	[12957]={s=0},  -- Shattered Sword of Marduk
	[12958]={s=12500},  -- Recipe: Transmute Arcanite
	[12960]={s=17125},  -- Tribal War Feathers
	[12963]={s=27717},  -- Blademaster Leggings
	[12964]={s=33388},  -- Tristam Legguards
	[12965]={s=22344},  -- Spiritshroud Leggings
	[12966]={s=14018},  -- Blackmist Armguards
	[12967]={s=16884},  -- Bloodmoon Cloak
	[12968]={s=16948},  -- Frostweaver Cape
	[12969]={s=70884},  -- Seeping Willow
	[12973]={s=0},  -- Scarlet Cannonball
	[12974]={s=6105},  -- The Black Knight
	[12975]={s=2205},  -- Prospector Axe
	[12976]={s=1770},  -- Ironpatch Blade
	[12977]={s=355},  -- Magefist Gloves
	[12978]={s=534},  -- Stormbringer Belt
	[12979]={s=617},  -- Firebane Cloak
	[12982]={s=850},  -- Silver-linked Footguards
	[12983]={s=2362},  -- Rakzur Club
	[12984]={s=1422},  -- Skycaller
	[12985]={s=1153},  -- Ring of Defense
	[12987]={s=906},  -- Darkweave Breeches
	[12988]={s=1137},  -- Starsight Tunic
	[12989]={s=2854},  -- Gargoyle's Bite
	[12990]={s=2589},  -- Razor's Edge
	[12992]={s=3260},  -- Searing Blade
	[12994]={s=787},  -- Thorbia's Gauntlets
	[12996]={s=1527},  -- Band of Purification
	[12997]={s=1920},  -- Redbeard Crest
	[12998]={s=1020},  -- Magician's Mantle
	[12999]={s=853},  -- Drakewing Bands
	[13000]={s=65225},  -- Staff of Hale Magefire
	[13001]={s=10648},  -- Maiden's Circle
	[13002]={s=14617},  -- Lady Alizabeth's Pendant
	[13003]={s=49640},  -- Lord Alexander's Battle Axe
	[13004]={s=33590},  -- Torch of Austen
	[13005]={s=1331},  -- Amy's Blanket
	[13006]={s=54840},  -- Mass of McGowan
	[13007]={s=13585},  -- Mageflame Cloak
	[13008]={s=12815},  -- Dalewind Trousers
	[13009]={s=15167},  -- Cow King's Hide
	[13010]={s=2241},  -- Dreamsinger Legguards
	[13011]={s=1031},  -- Silver-lined Belt
	[13012]={s=1241},  -- Yorgen Bracers
	[13013]={s=12355},  -- Elder Wizard's Mantle
	[13014]={s=34705},  -- Axe of Rin'ji
	[13015]={s=53957},  -- Serathil
	[13016]={s=4771},  -- Killmaim
	[13017]={s=17209},  -- Hellslayer Battle Axe
	[13018]={s=31967},  -- Executioner's Cleaver
	[13019]={s=4765},  -- Harpyclaw Short Bow
	[13020]={s=8985},  -- Skystriker Bow
	[13021]={s=16694},  -- Needle Threader
	[13022]={s=27990},  -- Gryphonwing Long Bow
	[13023]={s=42703},  -- Eaglehorn Long Bow
	[13024]={s=4863},  -- Beazel's Basher
	[13025]={s=10464},  -- Deadwood Sledge
	[13026]={s=19441},  -- Heaven's Light
	[13027]={s=33832},  -- Bonesnapper
	[13028]={s=52605},  -- Bludstone Hammer
	[13029]={s=5613},  -- Umbral Crystal
	[13030]={s=13113},  -- Basilisk Bone
	[13031]={s=1401},  -- Orb of Mistmantle
	[13032]={s=4138},  -- Sword of Corruption
	[13033]={s=8094},  -- Zealot Blade
	[13034]={s=14710},  -- Speedsteel Rapier
	[13035]={s=25141},  -- Serpent Slicer
	[13036]={s=40988},  -- Assassination Blade
	[13037]={s=4729},  -- Crystalpine Stinger
	[13038]={s=9630},  -- Swiftwind
	[13039]={s=17892},  -- Skull Splitting Crossbow
	[13040]={s=29444},  -- Heartseeking Crossbow
	[13041]={s=4516},  -- Guardian Blade
	[13042]={s=17596},  -- Sword of the Magistrate
	[13043]={s=32389},  -- Blade of the Titans
	[13044]={s=52800},  -- Demonslayer
	[13045]={s=10809},  -- Viscous Hammer
	[13046]={s=35042},  -- Blanchard's Stout
	[13047]={s=56588},  -- Twig of the World Tree
	[13048]={s=5971},  -- Looming Gavel
	[13049]={s=6191},  -- Deanship Claymore
	[13051]={s=22911},  -- Witchfury
	[13052]={s=41677},  -- Warmonger
	[13053]={s=59186},  -- Doombringer
	[13054]={s=15805},  -- Grim Reaper
	[13055]={s=29367},  -- Bonechewer
	[13056]={s=48330},  -- Frenzied Striker
	[13057]={s=5382},  -- Bloodpike
	[13058]={s=21833},  -- Khoo's Point
	[13059]={s=38719},  -- Stoneraven
	[13060]={s=60784},  -- The Needler
	[13062]={s=2991},  -- Thunderwood
	[13063]={s=5851},  -- Starfaller
	[13064]={s=11487},  -- Jaina's Firestarter
	[13065]={s=20945},  -- Wand of Allistarj
	[13066]={s=8997},  -- Wyrmslayer Spaulders
	[13067]={s=14341},  -- Hydralick Armor
	[13068]={s=4785},  -- Obsidian Greaves
	[13070]={s=14087},  -- Sapphiron's Scale Boots
	[13071]={s=4061},  -- Plated Fist of Hakoo
	[13072]={s=10426},  -- Stonegrip Gauntlets
	[13073]={s=9080},  -- Mugthol's Helm
	[13074]={s=8024},  -- Golem Shard Leggings
	[13075]={s=22090},  -- Direwing Legguards
	[13076]={s=4715},  -- Giantslayer Bracers
	[13077]={s=8226},  -- Girdle of Uther
	[13079]={s=3359},  -- Shield of Thorsen
	[13081]={s=7123},  -- Skullance Shield
	[13082]={s=13235},  -- Mountainside Buckler
	[13083]={s=34694},  -- Garrett Family Crest
	[13084]={s=6614},  -- Kaleidoscope Chain
	[13085]={s=9137},  -- Horizon Choker
	[13086]={s=0},  -- Reins of the Winterspring Frostsaber
	[13087]={s=5896},  -- River Pride Choker
	[13088]={s=7413},  -- Gazlowe's Charm
	[13089]={s=8039},  -- Skibi's Pendant
	[13091]={s=10637},  -- Medallion of Grand Marshal Morris
	[13093]={s=3381},  -- Blush Ember Ring
	[13094]={s=2646},  -- The Queen's Jewel
	[13095]={s=6646},  -- Assault Band
	[13096]={s=7913},  -- Band of the Hierophant
	[13097]={s=2164},  -- Thunderbrow Ring
	[13098]={s=15282},  -- Painweaver Band
	[13099]={s=1431},  -- Moccasins of the White Hare
	[13100]={s=5421},  -- Furen's Boots
	[13101]={s=14318},  -- Wolfrunner Shoes
	[13102]={s=6879},  -- Cassandra's Grace
	[13103]={s=3453},  -- Pads of the Venom Spider
	[13105]={s=2147},  -- Sutarn's Ring
	[13106]={s=1216},  -- Glowing Magical Bracelets
	[13107]={s=11291},  -- Magiskull Cuffs
	[13108]={s=2446},  -- Tigerstrike Mantle
	[13109]={s=8152},  -- Blackflame Cape
	[13110]={s=4968},  -- Wolffear Harness
	[13111]={s=13993},  -- Sandals of the Insurgent
	[13112]={s=9624},  -- Winged Helm
	[13113]={s=20546},  -- Feathermoon Headdress
	[13114]={s=2574},  -- Troll's Bane Leggings
	[13115]={s=6990},  -- Sheepshear Mantle
	[13116]={s=19370},  -- Spaulders of the Unseen
	[13117]={s=3830},  -- Ogron's Sash
	[13118]={s=10601},  -- Serpentine Sash
	[13119]={s=3063},  -- Enchanted Kodo Bracers
	[13120]={s=9505},  -- Deepfury Bracers
	[13121]={s=3428},  -- Wing of the Whelping
	[13122]={s=11489},  -- Dark Phantom Cape
	[13123]={s=33387},  -- Dreamwalker Armor
	[13124]={s=3996},  -- Ravasaur Scale Boots
	[13125]={s=12954},  -- Elven Chain Boots
	[13126]={s=10374},  -- Battlecaller Gauntlets
	[13127]={s=3021},  -- Frostreaver Crown
	[13128]={s=10543},  -- High Bergg Helm
	[13129]={s=7621},  -- Firemane Leggings
	[13130]={s=25065},  -- Windrunner Legguards
	[13131]={s=2312},  -- Sparkleshell Mantle
	[13132]={s=7340},  -- Skeletal Shoulders
	[13133]={s=23083},  -- Drakesfire Epaulets
	[13134]={s=7716},  -- Belt of the Gladiator
	[13135]={s=14001},  -- Lordly Armguards
	[13136]={s=1456},  -- Lil Timmy's Peashooter
	[13137]={s=5874},  -- Ironweaver
	[13138]={s=11532},  -- The Silencer
	[13139]={s=21029},  -- Guttbuster
	[13140]={s=0},  -- Blood Red Key
	[13141]={s=12093},  -- Tooth of Gnarr
	[13142]={s=11641},  -- Brigam Girdle
	[13143]={s=21372},  -- Mark of the Dragon Lord
	[13144]={s=6865},  -- Serenity Belt
	[13145]={s=2704},  -- Enormous Ogre Belt
	[13146]={s=34704},  -- Shell Launcher Shotgun
	[13148]={s=62629},  -- Chillpike
	[13155]={s=0},  -- Resonating Skull
	[13156]={s=0},  -- Mystic Crystal
	[13157]={s=0},  -- Fetid Skull
	[13158]={s=0},  -- Words of the High Chief
	[13159]={s=0},  -- Bone Dust
	[13161]={s=65749},  -- Trindlehaven Staff
	[13162]={s=10558},  -- Reiver Claws
	[13163]={s=69537},  -- Relentless Scythe
	[13164]={s=10539},  -- Heart of the Scale
	[13166]={s=14204},  -- Slamshot Shoulders
	[13167]={s=59410},  -- Fist of Omokk
	[13168]={s=19085},  -- Plate of the Shaman King
	[13169]={s=23948},  -- Tressermane Leggings
	[13170]={s=19230},  -- Skyshroud Leggings
	[13171]={s=7000},  -- Smokey's Lighter
	[13172]={s=0},  -- Siabi's Premium Tobacco
	[13173]={s=11},  -- Flightblade Throwing Axe
	[13174]={s=0},  -- Plagued Flesh Sample
	[13175]={s=30619},  -- Voone's Twitchbow
	[13176]={s=0},  -- Scourge Data
	[13177]={s=16396},  -- Talisman of Evasion
	[13178]={s=13782},  -- Rosewine Circle
	[13179]={s=14916},  -- Brazecore Armguards
	[13180]={s=0},  -- Stratholme Holy Water
	[13181]={s=8797},  -- Demonskin Gloves
	[13182]={s=30885},  -- Phase Blade
	[13183]={s=51771},  -- Venomspitter
	[13184]={s=13638},  -- Fallbrush Handgrips
	[13185]={s=16422},  -- Sunderseer Mantle
	[13186]={s=0},  -- Empty Felstone Field Bottle
	[13187]={s=0},  -- Empty Dalson's Tears Bottle
	[13188]={s=0},  -- Empty Writhing Haunt Bottle
	[13189]={s=0},  -- Empty Gahrron's Withering Bottle
	[13190]={s=0},  -- Filled Felstone Field Bottle
	[13191]={s=0},  -- Filled Dalson's Tears Bottle
	[13192]={s=0},  -- Filled Writhing Haunt Bottle
	[13193]={s=0},  -- Filled Gahrron's Withering Bottle
	[13194]={s=0},  -- Felstone Field Cauldron Key
	[13195]={s=0},  -- Dalson's Tears Cauldron Key
	[13196]={s=0},  -- Gahrron's Withering Cauldron Key
	[13197]={s=0},  -- Writhing Haunt Cauldron Key
	[13198]={s=50851},  -- Hurd Smasher
	[13199]={s=4398},  -- Crushridge Bindings
	[13202]={s=0},  -- Extended Annals of Darrowshire
	[13203]={s=19498},  -- Armswake Cloak
	[13204]={s=39263},  -- Bashguuder
	[13205]={s=35031},  -- Rhombeard Protector
	[13206]={s=19880},  -- Wolfshear Leggings
	[13207]={s=0},  -- Shadow Lord Fel'dan's Head
	[13208]={s=12520},  -- Bleak Howler Armguards
	[13209]={s=9615},  -- Seal of the Dawn
	[13210]={s=18024},  -- Pads of the Dread Wolf
	[13211]={s=12062},  -- Slashclaw Bracers
	[13212]={s=10670},  -- Halycon's Spiked Collar
	[13213]={s=9633},  -- Smolderweb's Eye
	[13216]={s=13250},  -- Crown of the Penitent
	[13217]={s=8814},  -- Band of the Penitent
	[13218]={s=53388},  -- Fang of the Crystal Spider
	[13243]={s=36515},  -- Argent Defender
	[13244]={s=12068},  -- Gilded Gauntlets
	[13245]={s=1064},  -- Kresh's Back
	[13246]={s=53622},  -- Argent Avenger
	[13247]={s=5837},  -- Quartermaster Zigris' Footlocker
	[13248]={s=29669},  -- Burstshot Harquebus
	[13249]={s=67782},  -- Argent Crusader
	[13250]={s=0},  -- Head of Balnazzar
	[13251]={s=0},  -- Head of Baron Rivendare
	[13252]={s=12434},  -- Cloudrunner Girdle
	[13253]={s=9983},  -- Hands of Power
	[13254]={s=21569},  -- Astral Guard
	[13255]={s=11972},  -- Trueaim Gauntlets
	[13257]={s=18088},  -- Demonic Runed Spaulders
	[13258]={s=13343},  -- Slaghide Gauntlets
	[13259]={s=16069},  -- Ribsteel Footguards
	[13260]={s=22561},  -- Wind Dancer Boots
	[13261]={s=10452},  -- Globe of D'sak
	[13282]={s=13684},  -- Ogreseer Tower Boots
	[13283]={s=14907},  -- Magus Ring
	[13284]={s=17312},  -- Swiftdart Battleboots
	[13285]={s=54924},  -- The Nicker
	[13286]={s=44106},  -- Rivenspike
	[13287]={s=625},  -- Pattern: Raptor Hide Harness
	[13288]={s=625},  -- Pattern: Raptor Hide Belt
	[13289]={s=0},  -- Egan's Blaster
	[13302]={s=0},  -- Market Row Postbox Key
	[13303]={s=0},  -- Crusaders' Square Postbox Key
	[13304]={s=0},  -- Festival Lane Postbox Key
	[13305]={s=0},  -- Elders' Square Postbox Key
	[13306]={s=0},  -- King's Square Postbox Key
	[13307]={s=0},  -- Fras Siabi's Postbox Key
	[13308]={s=450},  -- Schematic: Ice Deflector
	[13309]={s=250},  -- Schematic: Lovingly Crafted Boomstick
	[13310]={s=500},  -- Schematic: Accurate Scope
	[13311]={s=2500},  -- Schematic: Mechanical Dragonling
	[13313]={s=0},  -- Sacred Highborne Writings
	[13314]={s=30222},  -- Alanna's Embrace
	[13315]={s=11396},  -- Testament of Hope
	[13317]={s=0},  -- Whistle of the Ivory Raptor
	[13320]={s=0},  -- Arcane Quickener
	[13321]={s=0},  -- Green Mechanostrider
	[13322]={s=0},  -- Unpainted Mechanostrider
	[13326]={s=0},  -- White Mechanostrider Mod A
	[13327]={s=0},  -- Icy Blue Mechanostrider Mod A
	[13328]={s=0},  -- Black Ram
	[13329]={s=0},  -- Frost Ram
	[13331]={s=0},  -- Red Skeletal Horse
	[13332]={s=0},  -- Blue Skeletal Horse
	[13333]={s=0},  -- Brown Skeletal Horse
	[13334]={s=0},  -- Green Skeletal Warhorse
	[13335]={s=250000},  -- Deathcharger's Reins
	[13340]={s=16498},  -- Cape of the Black Baron
	[13344]={s=17210},  -- Dracorian Gauntlets
	[13345]={s=15457},  -- Seal of Rivendare
	[13346]={s=23118},  -- Robes of the Exalted
	[13347]={s=0},  -- Crystal of Zin-Malor
	[13348]={s=72769},  -- Demonshear
	[13349]={s=58428},  -- Scepter of the Unholy
	[13350]={s=0},  -- Insignia of the Black Guard
	[13351]={s=0},  -- Crimson Hammersmith's Apron
	[13352]={s=0},  -- Vosh'gajin's Snakestone
	[13353]={s=10452},  -- Book of the Dead
	[13354]={s=0},  -- Ectoplasmic Resonator
	[13356]={s=0},  -- Somatic Intensifier
	[13357]={s=0},  -- Osseous Agitator
	[13358]={s=21036},  -- Wyrmtongue Shoulders
	[13359]={s=25336},  -- Crown of Tyranny
	[13360]={s=56517},  -- Gift of the Elven Magi
	[13361]={s=56730},  -- Skullforge Reaver
	[13362]={s=2000},  -- Letter from the Front
	[13363]={s=2000},  -- Municipal Proclamation
	[13364]={s=2000},  -- Fras Siabi's Advertisement
	[13365]={s=2000},  -- Town Meeting Notice
	[13366]={s=3000},  -- Ingenious Toy
	[13367]={s=0},  -- Wrapped Gift
	[13368]={s=55438},  -- Bonescraper
	[13369]={s=17526},  -- Fire Striders
	[13370]={s=0},  -- Vitreous Focuser
	[13371]={s=6657},  -- Father Flame
	[13372]={s=63769},  -- Slavedriver's Cane
	[13373]={s=14846},  -- Band of Flesh
	[13374]={s=14315},  -- Soulstealer Mantle
	[13375]={s=30656},  -- Crest of Retribution
	[13376]={s=13738},  -- Royal Tribunal Cloak
	[13377]={s=7},  -- Miniature Cannon Balls
	[13378]={s=21972},  -- Songbird Blouse
	[13379]={s=10734},  -- Piccolo of the Flaming Fire
	[13380]={s=38443},  -- Willey's Portable Howitzer
	[13381]={s=15433},  -- Master Cannoneer Boots
	[13382]={s=10850},  -- Cannonball Runner
	[13383]={s=26864},  -- Woollies of the Prancing Minstrel
	[13384]={s=8988},  -- Rainbow Girdle
	[13385]={s=13237},  -- Tome of Knowledge
	[13386]={s=16376},  -- Archivist Cape
	[13387]={s=13149},  -- Foresight Girdle
	[13388]={s=21117},  -- The Postmaster's Tunic
	[13389]={s=21746},  -- The Postmaster's Trousers
	[13390]={s=16367},  -- The Postmaster's Band
	[13391]={s=16425},  -- The Postmaster's Treads
	[13392]={s=12211},  -- The Postmaster's Seal
	[13393]={s=62380},  -- Malown's Slam
	[13394]={s=18176},  -- Skul's Cold Embrace
	[13395]={s=11403},  -- Skul's Fingerbone Claws
	[13396]={s=30853},  -- Skul's Ghastly Touch
	[13397]={s=15201},  -- Stoneskin Gargoyle Cape
	[13398]={s=20028},  -- Boots of the Shrieker
	[13399]={s=46312},  -- Gargoyle Shredder Talons
	[13400]={s=9296},  -- Vambraces of the Sadist
	[13401]={s=51440},  -- The Cruel Hand of Timmy
	[13402]={s=21168},  -- Timmy's Galoshes
	[13403]={s=9401},  -- Grimgore Noose
	[13404]={s=15895},  -- Mask of the Unforgiven
	[13405]={s=13102},  -- Wailing Nightbane Pauldrons
	[13408]={s=44142},  -- Soul Breaker
	[13409]={s=8119},  -- Tearfall Bracers
	[13422]={s=10},  -- Stonescale Eel
	[13423]={s=125},  -- Stonescale Oil
	[13442]={s=500},  -- Mighty Rage Potion
	[13443]={s=400},  -- Superior Mana Potion
	[13444]={s=1500},  -- Major Mana Potion
	[13445]={s=500},  -- Elixir of Superior Defense
	[13446]={s=1000},  -- Major Healing Potion
	[13447]={s=1250},  -- Elixir of the Sages
	[13448]={s=0},  -- The Deed to Caer Darrow
	[13450]={s=0},  -- The Deed to Southshore
	[13451]={s=0},  -- The Deed to Tarren Mill
	[13452]={s=1250},  -- Elixir of the Mongoose
	[13453]={s=1250},  -- Elixir of Brute Force
	[13454]={s=750},  -- Greater Arcane Elixir
	[13455]={s=750},  -- Greater Stoneshield Potion
	[13456]={s=750},  -- Greater Frost Protection Potion
	[13457]={s=750},  -- Greater Fire Protection Potion
	[13458]={s=750},  -- Greater Nature Protection Potion
	[13459]={s=100},  -- Greater Shadow Protection Potion
	[13461]={s=750},  -- Greater Arcane Protection Potion
	[13462]={s=750},  -- Purification Potion
	[13463]={s=100},  -- Dreamfoil
	[13464]={s=100},  -- Golden Sansam
	[13465]={s=150},  -- Mountain Silversage
	[13466]={s=250},  -- Plaguebloom
	[13467]={s=250},  -- Icecap
	[13468]={s=1000},  -- Black Lotus
	[13469]={s=0},  -- Head of Weldon Barov
	[13470]={s=0},  -- Head of Alexi Barov
	[13471]={s=0},  -- The Deed to Brill
	[13473]={s=7164},  -- Felstone Good Luck Charm
	[13474]={s=24724},  -- Farmer Dalson's Shotgun
	[13475]={s=8109},  -- Dalson Family Wedding Ring
	[13476]={s=3000},  -- Recipe: Mighty Rage Potion
	[13477]={s=3000},  -- Recipe: Superior Mana Potion
	[13478]={s=3250},  -- Recipe: Elixir of Superior Defense
	[13479]={s=3500},  -- Recipe: Elixir of the Sages
	[13480]={s=3750},  -- Recipe: Major Healing Potion
	[13481]={s=3750},  -- Recipe: Elixir of Brute Force
	[13482]={s=0},  -- Recipe: Transmute Air to Fire
	[13483]={s=0},  -- Recipe: Transmute Fire to Earth
	[13484]={s=0},  -- Recipe: Transmute Earth to Water
	[13485]={s=0},  -- Recipe: Transmute Water to Air
	[13486]={s=3750},  -- Recipe: Transmute Undeath to Water
	[13487]={s=3750},  -- Recipe: Transmute Water to Undeath
	[13488]={s=3750},  -- Recipe: Transmute Life to Earth
	[13489]={s=3750},  -- Recipe: Transmute Earth to Life
	[13490]={s=4000},  -- Recipe: Greater Stoneshield Potion
	[13491]={s=4000},  -- Recipe: Elixir of the Mongoose
	[13492]={s=5000},  -- Recipe: Purification Potion
	[13493]={s=5000},  -- Recipe: Greater Arcane Elixir
	[13494]={s=6000},  -- Recipe: Greater Fire Protection Potion
	[13495]={s=6000},  -- Recipe: Greater Frost Protection Potion
	[13496]={s=6000},  -- Recipe: Greater Nature Protection Potion
	[13497]={s=6000},  -- Recipe: Greater Arcane Protection Potion
	[13498]={s=18274},  -- Handcrafted Mastersmith Leggings
	[13499]={s=6000},  -- Recipe: Greater Shadow Protection Potion
	[13501]={s=7500},  -- Recipe: Major Mana Potion
	[13502]={s=11987},  -- Handcrafted Mastersmith Girdle
	[13503]={s=25000},  -- Alchemists' Stone
	[13505]={s=91345},  -- Runeblade of Baron Rivendare
	[13506]={s=5000},  -- Flask of Petrification
	[13507]={s=0},  -- Cliffwatcher Longhorn Report
	[13508]={s=4778},  -- Eye of Arachnida
	[13509]={s=5393},  -- Clutch of Foresight
	[13510]={s=5000},  -- Flask of the Titans
	[13511]={s=5000},  -- Flask of Distilled Wisdom
	[13512]={s=5000},  -- Flask of Supreme Power
	[13513]={s=5000},  -- Flask of Chromatic Resistance
	[13514]={s=5820},  -- Wail of the Banshee
	[13515]={s=9600},  -- Ramstein's Lightning Bolts
	[13518]={s=10000},  -- Recipe: Flask of Petrification
	[13519]={s=10000},  -- Recipe: Flask of the Titans
	[13520]={s=10000},  -- Recipe: Flask of Distilled Wisdom
	[13521]={s=10000},  -- Recipe: Flask of Supreme Power
	[13522]={s=10000},  -- Recipe: Flask of Chromatic Resistance
	[13523]={s=0},  -- Blood of Innocents
	[13524]={s=12458},  -- Skull of Burning Shadows
	[13525]={s=8698},  -- Darkbind Fingers
	[13526]={s=10897},  -- Flamescarred Girdle
	[13527]={s=13149},  -- Lavawalker Greaves
	[13528]={s=13198},  -- Twilight Void Bracers
	[13529]={s=32303},  -- Husk of Nerub'enkan
	[13530]={s=12453},  -- Fangdrip Runners
	[13531]={s=21191},  -- Crypt Stalker Leggings
	[13532]={s=12762},  -- Darkspinner Claws
	[13533]={s=12810},  -- Acid-etched Pauldrons
	[13534]={s=37727},  -- Banshee Finger
	[13535]={s=16829},  -- Coldtouch Phantom Wraps
	[13536]={s=0},  -- Horn of Awakening
	[13537]={s=9884},  -- Chillhide Bracers
	[13538]={s=19223},  -- Windshrieker Pauldrons
	[13539]={s=8535},  -- Banshee's Touch
	[13542]={s=0},  -- Demon Box
	[13544]={s=0},  -- Spectral Essence
	[13545]={s=0},  -- Shellfish
	[13546]={s=62},  -- Bloodbelly Fish
	[13562]={s=0},  -- Remains of Trey Lightforge
	[13582]={s=0},  -- Zergling Leash
	[13583]={s=0},  -- Panda Collar
	[13584]={s=0},  -- Diablo Stone
	[13585]={s=0},  -- Keepsake of Remembrance
	[13602]={s=0},  -- Greater Spellstone
	[13603]={s=0},  -- Major Spellstone
	[13624]={s=0},  -- Soulbound Keepsake
	[13626]={s=0},  -- Human Head of Ras Frostwhisper
	[13699]={s=0},  -- Firestone
	[13700]={s=0},  -- Greater Firestone
	[13701]={s=0},  -- Major Firestone
	[13702]={s=0},  -- Doom Weed
	[13703]={s=0},  -- Kodo Bone
	[13704]={s=0},  -- Skeleton Key
	[13724]={s=300},  -- Enriched Manna Biscuit
	[13725]={s=0},  -- Krastinov's Bag of Horrors
	[13752]={s=0},  -- Soulbound Keepsake
	[13754]={s=6},  -- Raw Glossy Mightfish
	[13755]={s=7},  -- Winter Squid
	[13756]={s=9},  -- Raw Summer Bass
	[13757]={s=10},  -- Lightning Eel
	[13758]={s=4},  -- Raw Redgill
	[13759]={s=10},  -- Raw Nightfin Snapper
	[13760]={s=10},  -- Raw Sunscale Salmon
	[13761]={s=0},  -- Frozen Eggs
	[13810]={s=300},  -- Blessed Sunfruit
	[13813]={s=300},  -- Blessed Sunfruit Juice
	[13815]={s=0},  -- Some Rune
	[13816]={s=10561},  -- Fine Longsword
	[13817]={s=18796},  -- Tapered Greatsword
	[13818]={s=13431},  -- Jagged Axe
	[13819]={s=19880},  -- Balanced War Axe
	[13820]={s=12042},  -- Clout Mace
	[13821]={s=17993},  -- Bulky Maul
	[13822]={s=11442},  -- Spiked Dagger
	[13823]={s=11924},  -- Stout War Staff
	[13824]={s=9015},  -- Recurve Long Bow
	[13825]={s=10168},  -- Primed Musket
	[13850]={s=0},  -- Rumbleshot's Ammo
	[13851]={s=312},  -- Hot Wolf Ribs
	[13852]={s=0},  -- The Grand Crusader's Command
	[13853]={s=0},  -- Slab of Carrion Worm Meat
	[13856]={s=5112},  -- Runecloth Belt
	[13857]={s=10878},  -- Runecloth Tunic
	[13858]={s=10917},  -- Runecloth Robe
	[13860]={s=8741},  -- Runecloth Cloak
	[13863]={s=6617},  -- Runecloth Gloves
	[13864]={s=9553},  -- Runecloth Boots
	[13865]={s=13555},  -- Runecloth Pants
	[13866]={s=11358},  -- Runecloth Headband
	[13867]={s=12570},  -- Runecloth Shoulders
	[13868]={s=9665},  -- Frostweave Robe
	[13869]={s=9702},  -- Frostweave Tunic
	[13870]={s=5471},  -- Frostweave Gloves
	[13871]={s=13436},  -- Frostweave Pants
	[13872]={s=0},  -- Bundle of Wood
	[13873]={s=0},  -- Viewing Room Key
	[13874]={s=1},  -- Heavy Crate
	[13875]={s=1},  -- Ironbound Locked Chest
	[13876]={s=25},  -- 40 Pound Grouper
	[13877]={s=30},  -- 47 Pound Grouper
	[13878]={s=32},  -- 53 Pound Grouper
	[13879]={s=35},  -- 59 Pound Grouper
	[13880]={s=37},  -- 68 Pound Grouper
	[13881]={s=100},  -- Bloated Redgill
	[13882]={s=60},  -- 42 Pound Redgill
	[13883]={s=60},  -- 45 Pound Redgill
	[13885]={s=50},  -- 34 Pound Redgill
	[13886]={s=50},  -- 37 Pound Redgill
	[13888]={s=12},  -- Darkclaw Lobster
	[13889]={s=5},  -- Raw Whitescale Salmon
	[13890]={s=70},  -- Plated Armorfish
	[13892]={s=0},  -- Kodo Kombobulator
	[13893]={s=15},  -- Large Raw Mightfish
	[13896]={s=11020},  -- Blue Wedding Hanbok
	[13897]={s=595},  -- White Traditional Hanbok
	[13898]={s=57739},  -- Royal Dangui
	[13899]={s=3528},  -- Red Traditional Hanbok
	[13900]={s=27442},  -- Green Wedding Hanbok
	[13901]={s=25},  -- 15 Pound Salmon
	[13902]={s=25},  -- 18 Pound Salmon
	[13903]={s=25},  -- 22 Pound Salmon
	[13904]={s=25},  -- 25 Pound Salmon
	[13905]={s=25},  -- 29 Pound Salmon
	[13907]={s=50},  -- 7 Pound Lobster
	[13908]={s=55},  -- 9 Pound Lobster
	[13909]={s=55},  -- 12 Pound Lobster
	[13910]={s=62},  -- 15 Pound Lobster
	[13911]={s=80},  -- 19 Pound Lobster
	[13912]={s=90},  -- 21 Pound Lobster
	[13914]={s=125},  -- 70 Pound Mightfish
	[13915]={s=125},  -- 85 Pound Mightfish
	[13918]={s=1},  -- Reinforced Locked Chest
	[13920]={s=0},  -- Healthy Dragon Scale
	[13926]={s=10000},  -- Golden Pearl
	[13927]={s=8},  -- Cooked Glossy Mightfish
	[13928]={s=8},  -- Grilled Squid
	[13929]={s=10},  -- Hot Smoked Bass
	[13930]={s=5},  -- Filet of Redgill
	[13931]={s=12},  -- Nightfin Soup
	[13932]={s=12},  -- Poached Sunscale Salmon
	[13933]={s=14},  -- Lobster Stew
	[13934]={s=18},  -- Mightfish Steak
	[13935]={s=10},  -- Baked Salmon
	[13937]={s=87013},  -- Headmaster's Charge
	[13938]={s=39304},  -- Bonecreeper Stylus
	[13939]={s=4000},  -- Recipe: Spotted Yellowtail
	[13940]={s=4000},  -- Recipe: Cooked Glossy Mightfish
	[13941]={s=4000},  -- Recipe: Filet of Redgill
	[13942]={s=4000},  -- Recipe: Grilled Squid
	[13943]={s=4000},  -- Recipe: Hot Smoked Bass
	[13944]={s=26808},  -- Tombstone Breastplate
	[13945]={s=5000},  -- Recipe: Nightfin Soup
	[13946]={s=5000},  -- Recipe: Poached Sunscale Salmon
	[13947]={s=5000},  -- Recipe: Lobster Stew
	[13948]={s=5000},  -- Recipe: Mightfish Steak
	[13949]={s=5000},  -- Recipe: Baked Salmon
	[13950]={s=16447},  -- Detention Strap
	[13951]={s=11005},  -- Vigorsteel Vambraces
	[13952]={s=56683},  -- Iceblade Hacker
	[13953]={s=56880},  -- Silent Fang
	[13954]={s=20386},  -- Verdant Footpads
	[13955]={s=16367},  -- Stoneform Shoulders
	[13956]={s=10950},  -- Clutch of Andros
	[13957]={s=12427},  -- Gargoyle Slashers
	[13958]={s=9505},  -- Wyrmthalak's Shackles
	[13959]={s=9542},  -- Omokk's Girth Restrainer
	[13960]={s=12828},  -- Heart of the Fiend
	[13961]={s=18028},  -- Halycon's Muzzle
	[13962]={s=12064},  -- Vosh'gajin's Strand
	[13963]={s=14533},  -- Voone's Vice Grips
	[13964]={s=52306},  -- Witchblade
	[13965]={s=16250},  -- Blackhand's Breadth
	[13966]={s=16250},  -- Mark of Tyranny
	[13967]={s=23338},  -- Windreaver Greaves
	[13968]={s=16250},  -- Eye of the Beast
	[13969]={s=16019},  -- Loomguard Armbraces
	[13982]={s=69826},  -- Warblade of Caer Darrow
	[13983]={s=66754},  -- Gravestone War Axe
	[13984]={s=57806},  -- Darrowspike
	[13986]={s=17469},  -- Crown of Caer Darrow
	[14002]={s=36720},  -- Darrowshire Strongguard
	[14022]={s=8991},  -- Barov Peasant Caller
	[14023]={s=8991},  -- Barov Peasant Caller
	[14024]={s=52422},  -- Frightalon
	[14025]={s=188},  -- Mystic's Belt
	[14042]={s=10561},  -- Cindercloth Vest
	[14043]={s=5955},  -- Cindercloth Gloves
	[14044]={s=9503},  -- Cindercloth Cloak
	[14045]={s=13480},  -- Cindercloth Pants
	[14046]={s=5000},  -- Runecloth Bag
	[14047]={s=400},  -- Runecloth
	[14048]={s=2000},  -- Bolt of Runecloth
	[14086]={s=45},  -- Beaded Sandals
	[14087]={s=16},  -- Beaded Cuffs
	[14088]={s=24},  -- Beaded Cloak
	[14089]={s=30},  -- Beaded Gloves
	[14090]={s=119},  -- Beaded Britches
	[14091]={s=119},  -- Beaded Robe
	[14093]={s=21},  -- Beaded Cord
	[14094]={s=121},  -- Beaded Wraps
	[14095]={s=36},  -- Native Bands
	[14096]={s=325},  -- Native Vest
	[14097]={s=236},  -- Native Pants
	[14098]={s=43},  -- Native Cloak
	[14099]={s=47},  -- Native Sash
	[14100]={s=12089},  -- Brightcloth Robe
	[14101]={s=6066},  -- Brightcloth Gloves
	[14102]={s=60},  -- Native Handwraps
	[14103]={s=9716},  -- Brightcloth Cloak
	[14104]={s=15484},  -- Brightcloth Pants
	[14106]={s=18053},  -- Felcloth Robe
	[14107]={s=13140},  -- Felcloth Pants
	[14108]={s=11112},  -- Felcloth Boots
	[14109]={s=341},  -- Native Robe
	[14110]={s=84},  -- Native Sandals
	[14111]={s=10775},  -- Felcloth Hood
	[14112]={s=13509},  -- Felcloth Shoulders
	[14113]={s=139},  -- Aboriginal Sash
	[14114]={s=242},  -- Aboriginal Footwraps
	[14115]={s=70},  -- Aboriginal Bands
	[14116]={s=106},  -- Aboriginal Cape
	[14117]={s=163},  -- Aboriginal Gloves
	[14119]={s=378},  -- Aboriginal Loincloth
	[14120]={s=577},  -- Aboriginal Robe
	[14121]={s=579},  -- Aboriginal Vest
	[14122]={s=219},  -- Ritual Bands
	[14123]={s=287},  -- Ritual Cape
	[14124]={s=292},  -- Ritual Gloves
	[14125]={s=676},  -- Ritual Kilt
	[14126]={s=396},  -- Ritual Amice
	[14127]={s=999},  -- Ritual Shroud
	[14128]={s=16093},  -- Wizardweave Robe
	[14129]={s=415},  -- Ritual Sandals
	[14130]={s=12768},  -- Wizardweave Turban
	[14131]={s=242},  -- Ritual Belt
	[14132]={s=12441},  -- Wizardweave Leggings
	[14133]={s=950},  -- Ritual Tunic
	[14134]={s=11280},  -- Cloak of Fire
	[14136]={s=17025},  -- Robe of Winter Night
	[14137]={s=18113},  -- Mooncloth Leggings
	[14138]={s=20042},  -- Mooncloth Vest
	[14139]={s=15840},  -- Mooncloth Shoulders
	[14140]={s=16693},  -- Mooncloth Circlet
	[14141]={s=12859},  -- Ghostweave Vest
	[14142]={s=6087},  -- Ghostweave Gloves
	[14143]={s=5763},  -- Ghostweave Belt
	[14144]={s=14374},  -- Ghostweave Pants
	[14145]={s=1032},  -- Cursed Felblade
	[14146]={s=14084},  -- Gloves of Spell Mastery
	[14147]={s=311},  -- Cavedweller Bracers
	[14148]={s=208},  -- Crystalline Cuffs
	[14149]={s=307},  -- Subterranean Cape
	[14150]={s=420},  -- Robe of Evocation
	[14151]={s=1055},  -- Chanting Blade
	[14152]={s=28815},  -- Robe of the Archmage
	[14153]={s=28920},  -- Robe of the Void
	[14154]={s=29028},  -- Truefaith Vestments
	[14155]={s=20000},  -- Mooncloth Bag
	[14156]={s=40000},  -- Bottomless Bag
	[14157]={s=433},  -- Pagan Mantle
	[14158]={s=1236},  -- Pagan Vest
	[14159]={s=570},  -- Pagan Shoes
	[14160]={s=251},  -- Pagan Bands
	[14161]={s=337},  -- Pagan Cape
	[14162]={s=445},  -- Pagan Mitts
	[14163]={s=1168},  -- Pagan Wraps
	[14164]={s=312},  -- Pagan Belt
	[14165]={s=1041},  -- Pagan Britches
	[14166]={s=238},  -- Buccaneer's Bracers
	[14167]={s=358},  -- Buccaneer's Cape
	[14168]={s=275},  -- Buccaneer's Gloves
	[14169]={s=286},  -- Aboriginal Shoulder Pads
	[14170]={s=331},  -- Buccaneer's Mantle
	[14171]={s=738},  -- Buccaneer's Pants
	[14172]={s=837},  -- Buccaneer's Robes
	[14173]={s=281},  -- Buccaneer's Cord
	[14174]={s=368},  -- Buccaneer's Boots
	[14175]={s=847},  -- Buccaneer's Vest
	[14176]={s=920},  -- Watcher's Boots
	[14177]={s=631},  -- Watcher's Cuffs
	[14178]={s=1532},  -- Watcher's Cap
	[14179]={s=747},  -- Watcher's Cape
	[14180]={s=1870},  -- Watcher's Jerkin
	[14181]={s=775},  -- Watcher's Handwraps
	[14182]={s=1167},  -- Watcher's Mantle
	[14183]={s=1710},  -- Watcher's Leggings
	[14184]={s=1716},  -- Watcher's Robes
	[14185]={s=647},  -- Watcher's Cinch
	[14186]={s=1179},  -- Raincaller Mantle
	[14187]={s=717},  -- Raincaller Cuffs
	[14188]={s=982},  -- Raincaller Cloak
	[14189]={s=1588},  -- Raincaller Cap
	[14190]={s=1932},  -- Raincaller Vest
	[14191]={s=881},  -- Raincaller Mitts
	[14192]={s=1946},  -- Raincaller Robes
	[14193]={s=2006},  -- Raincaller Pants
	[14194]={s=756},  -- Raincaller Cord
	[14195]={s=1252},  -- Raincaller Boots
	[14196]={s=1673},  -- Thistlefur Sandals
	[14197]={s=925},  -- Thistlefur Bands
	[14198]={s=1531},  -- Thistlefur Cloak
	[14199]={s=1240},  -- Thistlefur Gloves
	[14200]={s=2258},  -- Thistlefur Cap
	[14201]={s=2060},  -- Thistlefur Mantle
	[14202]={s=3336},  -- Thistlefur Jerkin
	[14203]={s=2754},  -- Thistlefur Pants
	[14204]={s=3041},  -- Thistlefur Robe
	[14205]={s=1042},  -- Thistlefur Belt
	[14206]={s=1046},  -- Vital Bracelets
	[14207]={s=3076},  -- Vital Leggings
	[14208]={s=2316},  -- Vital Headband
	[14209]={s=1196},  -- Vital Sash
	[14210]={s=1636},  -- Vital Cape
	[14211]={s=1325},  -- Vital Handwraps
	[14212]={s=2194},  -- Vital Shoulders
	[14213]={s=3553},  -- Vital Raiment
	[14214]={s=2009},  -- Vital Boots
	[14215]={s=3579},  -- Vital Tunic
	[14216]={s=4887},  -- Geomancer's Jerkin
	[14217]={s=1638},  -- Geomancer's Cord
	[14218]={s=2713},  -- Geomancer's Boots
	[14219]={s=2046},  -- Geomancer's Cloak
	[14220]={s=3442},  -- Geomancer's Cap
	[14221]={s=1510},  -- Geomancer's Bracers
	[14222]={s=1834},  -- Geomancer's Gloves
	[14223]={s=2698},  -- Geomancer's Spaulders
	[14224]={s=3901},  -- Geomancer's Trousers
	[14225]={s=4694},  -- Geomancer's Wraps
	[14226]={s=1731},  -- Embersilk Bracelets
	[14227]={s=2500},  -- Ironweb Spider Silk
	[14228]={s=3559},  -- Embersilk Coronet
	[14229]={s=2387},  -- Embersilk Cloak
	[14230]={s=5164},  -- Embersilk Tunic
	[14231]={s=1904},  -- Embersilk Mitts
	[14232]={s=3097},  -- Embersilk Mantle
	[14233]={s=4476},  -- Embersilk Leggings
	[14234]={s=5240},  -- Embersilk Robes
	[14235]={s=1789},  -- Embersilk Cord
	[14236]={s=2909},  -- Embersilk Boots
	[14237]={s=7206},  -- Darkmist Armor
	[14238]={s=3691},  -- Darkmist Boots
	[14239]={s=3176},  -- Darkmist Cape
	[14240]={s=2294},  -- Darkmist Bands
	[14241]={s=2311},  -- Darkmist Handguards
	[14242]={s=5413},  -- Darkmist Pants
	[14243]={s=4075},  -- Darkmist Mantle
	[14244]={s=6870},  -- Darkmist Wraps
	[14245]={s=2346},  -- Darkmist Girdle
	[14246]={s=4451},  -- Darkmist Wizard Hat
	[14247]={s=4467},  -- Lunar Mantle
	[14248]={s=2372},  -- Lunar Bindings
	[14249]={s=7559},  -- Lunar Vest
	[14250]={s=3872},  -- Lunar Slippers
	[14251]={s=3332},  -- Lunar Cloak
	[14252]={s=4914},  -- Lunar Coronet
	[14253]={s=2819},  -- Lunar Handwraps
	[14254]={s=7698},  -- Lunar Raiment
	[14255]={s=2628},  -- Lunar Belt
	[14256]={s=2000},  -- Felcloth
	[14257]={s=6194},  -- Lunar Leggings
	[14258]={s=3109},  -- Bloodwoven Cord
	[14259]={s=5056},  -- Bloodwoven Boots
	[14260]={s=2900},  -- Bloodwoven Bracers
	[14261]={s=4044},  -- Bloodwoven Cloak
	[14262]={s=3156},  -- Bloodwoven Mitts
	[14263]={s=5987},  -- Bloodwoven Mask
	[14264]={s=8013},  -- Bloodwoven Pants
	[14265]={s=9853},  -- Bloodwoven Wraps
	[14266]={s=5606},  -- Bloodwoven Pads
	[14267]={s=9926},  -- Bloodwoven Jerkin
	[14268]={s=3486},  -- Gaea's Cuffs
	[14269]={s=5669},  -- Gaea's Slippers
	[14270]={s=4877},  -- Gaea's Cloak
	[14271]={s=6599},  -- Gaea's Circlet
	[14272]={s=3820},  -- Gaea's Handwraps
	[14273]={s=6374},  -- Gaea's Amice
	[14274]={s=10448},  -- Gaea's Leggings
	[14275]={s=11115},  -- Gaea's Raiment
	[14276]={s=3598},  -- Gaea's Belt
	[14277]={s=10131},  -- Gaea's Tunic
	[14278]={s=6725},  -- Opulent Mantle
	[14279]={s=4206},  -- Opulent Bracers
	[14280]={s=5919},  -- Opulent Cape
	[14281]={s=8178},  -- Opulent Crown
	[14282]={s=4552},  -- Opulent Gloves
	[14283]={s=11646},  -- Opulent Leggings
	[14284]={s=13135},  -- Opulent Robes
	[14285]={s=6905},  -- Opulent Boots
	[14286]={s=4620},  -- Opulent Belt
	[14287]={s=13282},  -- Opulent Tunic
	[14288]={s=14132},  -- Arachnidian Armor
	[14289]={s=5131},  -- Arachnidian Girdle
	[14290]={s=7725},  -- Arachnidian Footpads
	[14291]={s=4830},  -- Arachnidian Bracelets
	[14292]={s=6795},  -- Arachnidian Cape
	[14293]={s=9857},  -- Arachnidian Circlet
	[14294]={s=5223},  -- Arachnidian Gloves
	[14295]={s=13236},  -- Arachnidian Legguards
	[14296]={s=7568},  -- Arachnidian Pauldrons
	[14297]={s=13556},  -- Arachnidian Robes
	[14298]={s=9628},  -- Bonecaster's Spaulders
	[14299]={s=8602},  -- Bonecaster's Boots
	[14300]={s=7685},  -- Bonecaster's Cape
	[14301]={s=5451},  -- Bonecaster's Bindings
	[14302]={s=6517},  -- Bonecaster's Gloves
	[14303]={s=16209},  -- Bonecaster's Shroud
	[14304]={s=6194},  -- Bonecaster's Belt
	[14305]={s=14349},  -- Bonecaster's Sarong
	[14306]={s=16830},  -- Bonecaster's Vest
	[14307]={s=12064},  -- Bonecaster's Crown
	[14308]={s=17799},  -- Celestial Tunic
	[14309]={s=6866},  -- Celestial Belt
	[14310]={s=11615},  -- Celestial Slippers
	[14311]={s=6524},  -- Celestial Bindings
	[14312]={s=13541},  -- Celestial Crown
	[14313]={s=9298},  -- Celestial Cape
	[14314]={s=7854},  -- Celestial Handwraps
	[14315]={s=16550},  -- Celestial Kilt
	[14316]={s=11271},  -- Celestial Pauldrons
	[14317]={s=16633},  -- Celestial Silk Robes
	[14318]={s=18408},  -- Resplendent Tunic
	[14319]={s=11401},  -- Resplendent Boots
	[14320]={s=6855},  -- Resplendent Bracelets
	[14321]={s=9438},  -- Resplendent Cloak
	[14322]={s=13712},  -- Resplendent Circlet
	[14323]={s=8322},  -- Resplendent Gauntlets
	[14324]={s=16706},  -- Resplendent Sarong
	[14325]={s=13204},  -- Resplendent Epaulets
	[14326]={s=19479},  -- Resplendent Robes
	[14327]={s=7659},  -- Resplendent Belt
	[14329]={s=14066},  -- Eternal Boots
	[14330]={s=8962},  -- Eternal Bindings
	[14331]={s=11654},  -- Eternal Cloak
	[14332]={s=15674},  -- Eternal Crown
	[14333]={s=9987},  -- Eternal Gloves
	[14334]={s=20044},  -- Eternal Sarong
	[14335]={s=15086},  -- Eternal Spaulders
	[14336]={s=20137},  -- Eternal Wraps
	[14337]={s=8546},  -- Eternal Cord
	[14338]={s=0},  -- Empty Water Tube
	[14339]={s=0},  -- Moonwell Water Tube
	[14340]={s=21778},  -- Freezing Lich Robes
	[14341]={s=1250},  -- Rune Thread
	[14342]={s=4000},  -- Mooncloth
	[14343]={s=0},  -- Small Brilliant Shard
	[14344]={s=0},  -- Large Brilliant Shard
	[14364]={s=324},  -- Mystic's Slippers
	[14365]={s=214},  -- Mystic's Cape
	[14366]={s=189},  -- Mystic's Bracelets
	[14367]={s=251},  -- Mystic's Gloves
	[14368]={s=346},  -- Mystic's Shoulder Pads
	[14369]={s=809},  -- Mystic's Wrap
	[14370]={s=472},  -- Mystic's Woolies
	[14371]={s=815},  -- Mystic's Robe
	[14372]={s=1430},  -- Sanguine Armor
	[14373]={s=524},  -- Sanguine Belt
	[14374]={s=699},  -- Sanguine Sandals
	[14375]={s=528},  -- Sanguine Cuffs
	[14376]={s=551},  -- Sanguine Cape
	[14377]={s=602},  -- Sanguine Handwraps
	[14378]={s=997},  -- Sanguine Mantle
	[14379]={s=1615},  -- Sanguine Trousers
	[14380]={s=1473},  -- Sanguine Robe
	[14381]={s=0},  -- Grimtotem Satchel
	[14395]={s=0},  -- Spells of Shadow
	[14396]={s=0},  -- Incantations from the Nether
	[14397]={s=1600},  -- Resilient Mantle
	[14398]={s=2355},  -- Resilient Tunic
	[14399]={s=1465},  -- Resilient Boots
	[14400]={s=1215},  -- Resilient Cape
	[14401]={s=1786},  -- Resilient Cap
	[14402]={s=837},  -- Resilient Bands
	[14403]={s=1017},  -- Resilient Handgrips
	[14404]={s=2471},  -- Resilient Leggings
	[14405]={s=2480},  -- Resilient Robe
	[14406]={s=935},  -- Resilient Cord
	[14407]={s=4266},  -- Stonecloth Vest
	[14408]={s=2275},  -- Stonecloth Boots
	[14409]={s=1707},  -- Stonecloth Cape
	[14410]={s=2709},  -- Stonecloth Circlet
	[14411]={s=1387},  -- Stonecloth Gloves
	[14412]={s=2298},  -- Stonecloth Epaulets
	[14413]={s=3947},  -- Stonecloth Robe
	[14414]={s=1276},  -- Stonecloth Belt
	[14415]={s=3410},  -- Stonecloth Britches
	[14416]={s=1285},  -- Stonecloth Bindings
	[14417]={s=5888},  -- Silksand Tunic
	[14418]={s=3098},  -- Silksand Boots
	[14419]={s=1919},  -- Silksand Bracers
	[14420]={s=2889},  -- Silksand Cape
	[14421]={s=3945},  -- Silksand Circlet
	[14422]={s=2262},  -- Silksand Gloves
	[14423]={s=3406},  -- Silksand Shoulder Pads
	[14424]={s=5316},  -- Silksand Legwraps
	[14425]={s=6223},  -- Silksand Wraps
	[14426]={s=2125},  -- Silksand Girdle
	[14427]={s=9124},  -- Windchaser Wraps
	[14428]={s=4717},  -- Windchaser Footpads
	[14429]={s=2644},  -- Windchaser Cuffs
	[14430]={s=3686},  -- Windchaser Cloak
	[14431]={s=2877},  -- Windchaser Handguards
	[14432]={s=4679},  -- Windchaser Amice
	[14433]={s=6764},  -- Windchaser Woolies
	[14434]={s=8706},  -- Windchaser Robes
	[14435]={s=2778},  -- Windchaser Cinch
	[14436]={s=5270},  -- Windchaser Coronet
	[14437]={s=12002},  -- Venomshroud Vest
	[14438]={s=6192},  -- Venomshroud Boots
	[14439]={s=3836},  -- Venomshroud Armguards
	[14440]={s=5347},  -- Venomshroud Cape
	[14441]={s=7166},  -- Venomshroud Mask
	[14442]={s=4481},  -- Venomshroud Mitts
	[14443]={s=6745},  -- Venomshroud Mantle
	[14444]={s=10955},  -- Venomshroud Leggings
	[14445]={s=12353},  -- Venomshroud Silk Robes
	[14446]={s=4248},  -- Venomshroud Belt
	[14447]={s=8801},  -- Highborne Footpads
	[14448]={s=5555},  -- Highborne Bracelets
	[14449]={s=10125},  -- Highborne Crown
	[14450]={s=7364},  -- Highborne Cloak
	[14451]={s=5536},  -- Highborne Gloves
	[14452]={s=8836},  -- Highborne Pauldrons
	[14453]={s=15677},  -- Highborne Robes
	[14454]={s=5598},  -- Highborne Cord
	[14455]={s=15792},  -- Highborne Padded Armor
	[14457]={s=7575},  -- Elunarian Cuffs
	[14458]={s=12573},  -- Elunarian Boots
	[14459]={s=10798},  -- Elunarian Cloak
	[14460]={s=14661},  -- Elunarian Diadem
	[14461]={s=9342},  -- Elunarian Handgrips
	[14462]={s=18751},  -- Elunarian Sarong
	[14463]={s=14114},  -- Elunarian Spaulders
	[14465]={s=8596},  -- Elunarian Belt
	[14466]={s=3000},  -- Pattern: Frostweave Tunic
	[14467]={s=3000},  -- Pattern: Frostweave Robe
	[14468]={s=3000},  -- Pattern: Runecloth Bag
	[14469]={s=3000},  -- Pattern: Runecloth Robe
	[14470]={s=3000},  -- Pattern: Runecloth Tunic
	[14471]={s=3000},  -- Pattern: Cindercloth Vest
	[14472]={s=3000},  -- Pattern: Runecloth Cloak
	[14473]={s=3000},  -- Pattern: Ghostweave Belt
	[14474]={s=3000},  -- Pattern: Frostweave Gloves
	[14476]={s=3500},  -- Pattern: Cindercloth Gloves
	[14477]={s=3500},  -- Pattern: Ghostweave Gloves
	[14478]={s=3500},  -- Pattern: Brightcloth Robe
	[14479]={s=3500},  -- Pattern: Brightcloth Gloves
	[14480]={s=4000},  -- Pattern: Ghostweave Vest
	[14481]={s=4000},  -- Pattern: Runecloth Gloves
	[14482]={s=4000},  -- Pattern: Cindercloth Cloak
	[14483]={s=4000},  -- Pattern: Felcloth Pants
	[14484]={s=4000},  -- Pattern: Brightcloth Cloak
	[14485]={s=4000},  -- Pattern: Wizardweave Leggings
	[14486]={s=10000},  -- Pattern: Cloak of Fire
	[14487]={s=53222},  -- Bonechill Hammer
	[14488]={s=5000},  -- Pattern: Runecloth Boots
	[14489]={s=5000},  -- Pattern: Frostweave Pants
	[14490]={s=5000},  -- Pattern: Cindercloth Pants
	[14491]={s=5000},  -- Pattern: Runecloth Pants
	[14492]={s=5000},  -- Pattern: Felcloth Boots
	[14493]={s=5000},  -- Pattern: Robe of Winter Night
	[14494]={s=5500},  -- Pattern: Brightcloth Pants
	[14496]={s=5500},  -- Pattern: Felcloth Hood
	[14497]={s=5500},  -- Pattern: Mooncloth Leggings
	[14498]={s=6250},  -- Pattern: Runecloth Headband
	[14499]={s=7500},  -- Pattern: Mooncloth Bag
	[14500]={s=7500},  -- Pattern: Wizardweave Robe
	[14501]={s=7500},  -- Pattern: Mooncloth Vest
	[14502]={s=13051},  -- Frostbite Girdle
	[14503]={s=19652},  -- Death's Clutch
	[14504]={s=10000},  -- Pattern: Runecloth Shoulders
	[14505]={s=10000},  -- Pattern: Wizardweave Turban
	[14506]={s=10000},  -- Pattern: Felcloth Robe
	[14507]={s=10000},  -- Pattern: Mooncloth Shoulders
	[14508]={s=15000},  -- Pattern: Felcloth Shoulders
	[14512]={s=15000},  -- Pattern: Truefaith Vestments
	[14513]={s=15000},  -- Pattern: Robe of the Archmage
	[14514]={s=15000},  -- Pattern: Robe of the Void
	[14522]={s=31318},  -- Maelstrom Leggings
	[14523]={s=0},  -- Demon Pick
	[14525]={s=10561},  -- Boneclenched Gauntlets
	[14526]={s=5000},  -- Pattern: Mooncloth
	[14528]={s=34181},  -- Rattlecage Buckler
	[14529]={s=500},  -- Runecloth Bandage
	[14530]={s=1000},  -- Heavy Runecloth Bandage
	[14531]={s=59891},  -- Frightskull Shaft
	[14536]={s=32271},  -- Bonebrace Hauberk
	[14537]={s=14167},  -- Corpselight Greaves
	[14538]={s=17062},  -- Deadwalker Mantle
	[14539]={s=21404},  -- Bone Ring Helm
	[14540]={s=0},  -- Taragaman the Hungerer's Heart
	[14541]={s=68426},  -- Barovian Family Sword
	[14542]={s=0},  -- Kravel's Crate
	[14543]={s=8732},  -- Darkshade Gloves
	[14544]={s=0},  -- Lieutenant's Insignia
	[14545]={s=21997},  -- Ghostloom Leggings
	[14546]={s=0},  -- Roon's Kodo Horn
	[14547]={s=0},  -- Hand of Iruxos
	[14548]={s=20660},  -- Royal Cap Spaulders
	[14549]={s=7807},  -- Boots of Avoidance
	[14551]={s=10601},  -- Edgemaster's Handguards
	[14552]={s=15378},  -- Stockade Pauldrons
	[14553]={s=17733},  -- Sash of Mercy
	[14554]={s=29900},  -- Cloudkeeper Legplates
	[14555]={s=78772},  -- Alcor's Sunrazor
	[14557]={s=17880},  -- The Lion Horn of Stormwind
	[14558]={s=10500},  -- Lady Maye's Pendant
	[14559]={s=279},  -- Prospector's Sash
	[14560]={s=484},  -- Prospector's Boots
	[14561]={s=245},  -- Prospector's Cuffs
	[14562]={s=1039},  -- Prospector's Chestpiece
	[14563]={s=275},  -- Prospector's Cloak
	[14564]={s=304},  -- Prospector's Mitts
	[14565]={s=809},  -- Prospector's Woolies
	[14566]={s=1010},  -- Prospector's Pads
	[14567]={s=529},  -- Bristlebark Belt
	[14568]={s=797},  -- Bristlebark Boots
	[14569]={s=472},  -- Bristlebark Bindings
	[14570]={s=1870},  -- Bristlebark Blouse
	[14571]={s=496},  -- Bristlebark Cape
	[14572]={s=609},  -- Bristlebark Gloves
	[14573]={s=1289},  -- Bristlebark Amice
	[14574]={s=1568},  -- Bristlebark Britches
	[14576]={s=48770},  -- Ebon Hilt of Marduk
	[14577]={s=21585},  -- Skullsmoke Pants
	[14578]={s=983},  -- Dokebi Cord
	[14579]={s=1791},  -- Dokebi Boots
	[14580]={s=818},  -- Dokebi Bracers
	[14581]={s=2912},  -- Dokebi Chestguard
	[14582]={s=1088},  -- Dokebi Cape
	[14583]={s=1333},  -- Dokebi Gloves
	[14584]={s=2673},  -- Dokebi Hat
	[14585]={s=2687},  -- Dokebi Leggings
	[14587]={s=2030},  -- Dokebi Mantle
	[14588]={s=1989},  -- Hawkeye's Cord
	[14589]={s=3294},  -- Hawkeye's Shoes
	[14590]={s=1821},  -- Hawkeye's Bracers
	[14591]={s=4180},  -- Hawkeye's Helm
	[14592]={s=5594},  -- Hawkeye's Tunic
	[14593]={s=2210},  -- Hawkeye's Cloak
	[14594]={s=2236},  -- Hawkeye's Gloves
	[14595]={s=4500},  -- Hawkeye's Breeches
	[14596]={s=3388},  -- Hawkeye's Epaulets
	[14598]={s=2655},  -- Warden's Waistband
	[14599]={s=4663},  -- Warden's Footpads
	[14600]={s=2675},  -- Warden's Wristbands
	[14601]={s=7307},  -- Warden's Wraps
	[14602]={s=2995},  -- Warden's Cloak
	[14603]={s=4383},  -- Warden's Mantle
	[14604]={s=5986},  -- Warden's Wizard Hat
	[14605]={s=6868},  -- Warden's Woolies
	[14606]={s=2955},  -- Warden's Gloves
	[14607]={s=5581},  -- Hawkeye's Buckler
	[14608]={s=3162},  -- Dokebi Buckler
	[14610]={s=0},  -- Araj's Scarab
	[14611]={s=32509},  -- Bloodmail Hauberk
	[14612]={s=27185},  -- Bloodmail Legguards
	[14613]={s=0},  -- Taelan's Hammer
	[14614]={s=13689},  -- Bloodmail Belt
	[14615]={s=12430},  -- Bloodmail Gauntlets
	[14616]={s=18799},  -- Bloodmail Boots
	[14617]={s=6250},  -- Sawbones Shirt
	[14619]={s=0},  -- Skeletal Fragments
	[14620]={s=8446},  -- Deathbone Girdle
	[14621]={s=12717},  -- Deathbone Sabatons
	[14622]={s=8510},  -- Deathbone Gauntlets
	[14623]={s=17085},  -- Deathbone Legguards
	[14624]={s=20578},  -- Deathbone Chestplate
	[14625]={s=0},  -- Symbol of Lost Honor
	[14626]={s=20732},  -- Necropile Robe
	[14627]={s=200},  -- Pattern: Bright Yellow Shirt
	[14628]={s=0},  -- Imbued Skeletal Fragments
	[14629]={s=8965},  -- Necropile Cuffs
	[14630]={s=250},  -- Pattern: Enchanter's Cowl
	[14631]={s=13542},  -- Necropile Boots
	[14632]={s=18121},  -- Necropile Leggings
	[14633]={s=13639},  -- Necropile Mantle
	[14634]={s=625},  -- Recipe: Frost Oil
	[14635]={s=750},  -- Pattern: Gem-studded Leather Belt
	[14636]={s=10396},  -- Cadaverous Belt
	[14637]={s=25048},  -- Cadaverous Armor
	[14638]={s=20954},  -- Cadaverous Leggings
	[14639]={s=375},  -- Schematic: Minor Recombobulator
	[14640]={s=10556},  -- Cadaverous Gloves
	[14641]={s=15895},  -- Cadaverous Walkers
	[14644]={s=0},  -- Skeleton Key Mold
	[14645]={s=0},  -- Unfinished Skeleton Key
	[14646]={s=0},  -- Northshire Gift Voucher
	[14647]={s=0},  -- Coldridge Valley Gift Voucher
	[14648]={s=0},  -- Shadowglen Gift Voucher
	[14649]={s=0},  -- Valley of Trials Gift Voucher
	[14650]={s=0},  -- Camp Narache Gift Voucher
	[14651]={s=0},  -- Deathknell Gift Voucher
	[14652]={s=4215},  -- Scorpashi Sash
	[14653]={s=6854},  -- Scorpashi Slippers
	[14654]={s=3931},  -- Scorpashi Wristbands
	[14655]={s=10392},  -- Scorpashi Breastplate
	[14656]={s=4300},  -- Scorpashi Cape
	[14657]={s=4195},  -- Scorpashi Gloves
	[14658]={s=7884},  -- Scorpashi Skullcap
	[14659]={s=9382},  -- Scorpashi Leggings
	[14660]={s=7063},  -- Scorpashi Shoulder Pads
	[14661]={s=5461},  -- Keeper's Cord
	[14662]={s=9413},  -- Keeper's Hooves
	[14663]={s=5141},  -- Keeper's Bindings
	[14664]={s=15058},  -- Keeper's Armor
	[14665]={s=6214},  -- Keeper's Cloak
	[14666]={s=6367},  -- Keeper's Gloves
	[14667]={s=10770},  -- Keeper's Wreath
	[14668]={s=13596},  -- Keeper's Woolies
	[14669]={s=9654},  -- Keeper's Mantle
	[14670]={s=20396},  -- Pridelord Armor
	[14671]={s=13012},  -- Pridelord Boots
	[14672]={s=7309},  -- Pridelord Bands
	[14673]={s=8303},  -- Pridelord Cape
	[14674]={s=8270},  -- Pridelord Girdle
	[14675]={s=8182},  -- Pridelord Gloves
	[14676]={s=13841},  -- Pridelord Halo
	[14677]={s=18524},  -- Pridelord Pants
	[14678]={s=13156},  -- Pridelord Pauldrons
	[14679]={s=0},  -- Of Love and Family
	[14680]={s=25101},  -- Indomitable Vest
	[14681]={s=17139},  -- Indomitable Boots
	[14682]={s=9906},  -- Indomitable Armguards
	[14683]={s=11932},  -- Indomitable Cloak
	[14684]={s=10477},  -- Indomitable Belt
	[14685]={s=11594},  -- Indomitable Gauntlets
	[14686]={s=18327},  -- Indomitable Headdress
	[14687]={s=23357},  -- Indomitable Leggings
	[14688]={s=16742},  -- Indomitable Epaulets
	[14722]={s=424},  -- War Paint Anklewraps
	[14723]={s=290},  -- War Paint Bindings
	[14724]={s=253},  -- War Paint Cloak
	[14725]={s=292},  -- War Paint Waistband
	[14726]={s=337},  -- War Paint Gloves
	[14727]={s=778},  -- War Paint Legguards
	[14728]={s=485},  -- War Paint Shoulder Pads
	[14729]={s=870},  -- War Paint Shield
	[14730]={s=1223},  -- War Paint Chestpiece
	[14742]={s=1118},  -- Hulking Boots
	[14743]={s=583},  -- Hulking Bands
	[14744]={s=2310},  -- Hulking Chestguard
	[14745]={s=444},  -- Hulking Cloak
	[14746]={s=589},  -- Hulking Belt
	[14747]={s=668},  -- Hulking Gauntlets
	[14748]={s=1550},  -- Hulking Leggings
	[14749]={s=1325},  -- Hulking Spaulders
	[14750]={s=1068},  -- Slayer's Cuffs
	[14751]={s=3454},  -- Slayer's Surcoat
	[14752]={s=978},  -- Slayer's Cape
	[14753]={s=2610},  -- Slayer's Skullcap
	[14754]={s=1193},  -- Slayer's Gloves
	[14755]={s=1118},  -- Slayer's Sash
	[14756]={s=1860},  -- Slayer's Slippers
	[14757]={s=3298},  -- Slayer's Pants
	[14758]={s=2267},  -- Slayer's Shoulder Pads
	[14759]={s=2009},  -- Enduring Bracers
	[14760]={s=6263},  -- Enduring Breastplate
	[14761]={s=2024},  -- Enduring Belt
	[14762]={s=4074},  -- Enduring Boots
	[14763]={s=1685},  -- Enduring Cape
	[14764]={s=2250},  -- Enduring Gauntlets
	[14765]={s=4427},  -- Enduring Circlet
	[14766]={s=5486},  -- Enduring Breeches
	[14767]={s=4478},  -- Enduring Pauldrons
	[14768]={s=8566},  -- Ravager's Armor
	[14769]={s=5554},  -- Ravager's Sandals
	[14770]={s=3172},  -- Ravager's Armguards
	[14771]={s=3030},  -- Ravager's Cloak
	[14772]={s=3284},  -- Ravager's Handwraps
	[14773]={s=3052},  -- Ravager's Cord
	[14774]={s=6252},  -- Ravager's Crown
	[14775]={s=8367},  -- Ravager's Woolies
	[14776]={s=6326},  -- Ravager's Mantle
	[14777]={s=9710},  -- Ravager's Shield
	[14778]={s=4933},  -- Khan's Bindings
	[14779]={s=13347},  -- Khan's Chestpiece
	[14780]={s=14289},  -- Khan's Buckler
	[14781]={s=4617},  -- Khan's Cloak
	[14782]={s=5004},  -- Khan's Gloves
	[14783]={s=5424},  -- Khan's Belt
	[14784]={s=8202},  -- Khan's Greaves
	[14785]={s=9558},  -- Khan's Helmet
	[14786]={s=11841},  -- Khan's Legguards
	[14787]={s=8323},  -- Khan's Mantle
	[14788]={s=6408},  -- Protector Armguards
	[14789]={s=17541},  -- Protector Breastplate
	[14790]={s=18781},  -- Protector Buckler
	[14791]={s=6056},  -- Protector Cape
	[14792]={s=6960},  -- Protector Gauntlets
	[14793]={s=6985},  -- Protector Waistband
	[14794]={s=10563},  -- Protector Ankleguards
	[14795]={s=12690},  -- Protector Helm
	[14796]={s=16983},  -- Protector Legguards
	[14797]={s=11427},  -- Protector Pads
	[14798]={s=24037},  -- Bloodlust Breastplate
	[14799]={s=17308},  -- Bloodlust Boots
	[14800]={s=25826},  -- Bloodlust Buckler
	[14801]={s=8156},  -- Bloodlust Cape
	[14802]={s=9749},  -- Bloodlust Gauntlets
	[14803]={s=9087},  -- Bloodlust Belt
	[14804]={s=16296},  -- Bloodlust Helm
	[14805]={s=20577},  -- Bloodlust Britches
	[14806]={s=15560},  -- Bloodlust Epaulets
	[14807]={s=8211},  -- Bloodlust Bracelets
	[14808]={s=11581},  -- Warstrike Belt
	[14809]={s=20276},  -- Warstrike Sabatons
	[14810]={s=11669},  -- Warstrike Armsplints
	[14813]={s=10601},  -- Warstrike Cape
	[14814]={s=21593},  -- Warstrike Helmet
	[14815]={s=13760},  -- Warstrike Gauntlets
	[14816]={s=27620},  -- Warstrike Legguards
	[14817]={s=20883},  -- Warstrike Shoulder Pads
	[14821]={s=5290},  -- Symbolic Breastplate
	[14825]={s=8595},  -- Symbolic Crest
	[14826]={s=2311},  -- Symbolic Gauntlets
	[14827]={s=2320},  -- Symbolic Belt
	[14828]={s=3772},  -- Symbolic Greaves
	[14829]={s=5049},  -- Symbolic Legplates
	[14830]={s=3801},  -- Symbolic Pauldrons
	[14831]={s=4120},  -- Symbolic Crown
	[14832]={s=2363},  -- Symbolic Vambraces
	[14833]={s=2988},  -- Tyrant's Gauntlets
	[14834]={s=2777},  -- Tyrant's Armguards
	[14835]={s=8192},  -- Tyrant's Chestpiece
	[14838]={s=2892},  -- Tyrant's Belt
	[14839]={s=4701},  -- Tyrant's Greaves
	[14840]={s=7925},  -- Tyrant's Legplates
	[14841]={s=4284},  -- Tyrant's Epaulets
	[14842]={s=12483},  -- Tyrant's Shield
	[14843]={s=5036},  -- Tyrant's Helm
	[14844]={s=11471},  -- Sunscale Chestguard
	[14846]={s=4534},  -- Sunscale Gauntlets
	[14847]={s=4254},  -- Sunscale Belt
	[14848]={s=6854},  -- Sunscale Sabatons
	[14849]={s=8271},  -- Sunscale Helmet
	[14850]={s=10442},  -- Sunscale Legplates
	[14851]={s=7416},  -- Sunscale Spaulders
	[14852]={s=19420},  -- Sunscale Shield
	[14853]={s=4174},  -- Sunscale Wristguards
	[14854]={s=16204},  -- Vanguard Breastplate
	[14855]={s=6502},  -- Vanguard Gauntlets
	[14856]={s=6156},  -- Vanguard Girdle
	[14857]={s=9266},  -- Vanguard Sabatons
	[14858]={s=11740},  -- Vanguard Headdress
	[14859]={s=14820},  -- Vanguard Legplates
	[14860]={s=10523},  -- Vanguard Pauldrons
	[14861]={s=5045},  -- Vanguard Vambraces
	[14862]={s=18339},  -- Warleader's Breastplate
	[14863]={s=7951},  -- Warleader's Gauntlets
	[14864]={s=7602},  -- Warleader's Belt
	[14865]={s=12018},  -- Warleader's Greaves
	[14866]={s=13301},  -- Warleader's Crown
	[14867]={s=17802},  -- Warleader's Leggings
	[14868]={s=13109},  -- Warleader's Shoulders
	[14869]={s=7577},  -- Warleader's Bracers
	[14872]={s=0},  -- Tirion's Gift
	[14894]={s=0},  -- Lily Root
	[14895]={s=4904},  -- Saltstone Surcoat
	[14896]={s=3418},  -- Saltstone Sabatons
	[14897]={s=2286},  -- Saltstone Gauntlets
	[14898]={s=2295},  -- Saltstone Girdle
	[14899]={s=3731},  -- Saltstone Helm
	[14900]={s=4298},  -- Saltstone Legplates
	[14901]={s=3494},  -- Saltstone Shoulder Pads
	[14902]={s=7482},  -- Saltstone Shield
	[14903]={s=2173},  -- Saltstone Armsplints
	[14904]={s=9245},  -- Brutish Breastplate
	[14905]={s=3217},  -- Brutish Gauntlets
	[14906]={s=2989},  -- Brutish Belt
	[14907]={s=6123},  -- Brutish Helmet
	[14908]={s=8195},  -- Brutish Legguards
	[14909]={s=4897},  -- Brutish Shoulders
	[14910]={s=3033},  -- Brutish Armguards
	[14911]={s=5327},  -- Brutish Boots
	[14912]={s=15232},  -- Brutish Shield
	[14913]={s=6697},  -- Jade Greaves
	[14914]={s=3590},  -- Jade Bracers
	[14915]={s=11569},  -- Jade Breastplate
	[14916]={s=17254},  -- Jade Deflector
	[14917]={s=3931},  -- Jade Gauntlets
	[14918]={s=3654},  -- Jade Belt
	[14919]={s=7717},  -- Jade Circlet
	[14920]={s=9744},  -- Jade Legplates
	[14921]={s=6407},  -- Jade Epaulets
	[14922]={s=8273},  -- Lofty Sabatons
	[14923]={s=4604},  -- Lofty Armguards
	[14924]={s=14031},  -- Lofty Breastplate
	[14925]={s=10562},  -- Lofty Helm
	[14926]={s=5598},  -- Lofty Gauntlets
	[14927]={s=5301},  -- Lofty Belt
	[14928]={s=12673},  -- Lofty Legguards
	[14929]={s=8999},  -- Lofty Shoulder Pads
	[14930]={s=22950},  -- Lofty Shield
	[14931]={s=18548},  -- Heroic Armor
	[14932]={s=11784},  -- Heroic Greaves
	[14933]={s=7884},  -- Heroic Gauntlets
	[14934]={s=6754},  -- Heroic Girdle
	[14935]={s=11885},  -- Heroic Skullcap
	[14936]={s=16702},  -- Heroic Legplates
	[14937]={s=11406},  -- Heroic Pauldrons
	[14938]={s=6470},  -- Heroic Bracers
	[14939]={s=6793},  -- Warbringer's Chestguard
	[14940]={s=4059},  -- Warbringer's Sabatons 
	[14941]={s=2515},  -- Warbringer's Armsplints
	[14942]={s=2524},  -- Warbringer's Gauntlets
	[14943]={s=2534},  -- Warbringer's Belt
	[14944]={s=4806},  -- Warbringer's Crown
	[14945]={s=6432},  -- Warbringer's Legguards
	[14946]={s=4151},  -- Warbringer's Spaulders
	[14947]={s=11198},  -- Warbringer's Shield
	[14948]={s=10301},  -- Bloodforged Chestpiece
	[14949]={s=3907},  -- Bloodforged Gauntlets
	[14950]={s=3630},  -- Bloodforged Belt
	[14951]={s=5902},  -- Bloodforged Sabatons
	[14952]={s=7323},  -- Bloodforged Helmet
	[14953]={s=9158},  -- Bloodforged Legplates
	[14954]={s=15234},  -- Bloodforged Shield
	[14955]={s=5418},  -- Bloodforged Shoulder Pads
	[14956]={s=3108},  -- Bloodforged Bindings
	[14957]={s=7223},  -- High Chief's Sabatons
	[14958]={s=12938},  -- High Chief's Armor
	[14959]={s=5143},  -- High Chief's Gauntlets
	[14960]={s=4870},  -- High Chief's Belt
	[14961]={s=9259},  -- High Chief's Crown
	[14962]={s=11690},  -- High Chief's Legguards
	[14963]={s=8301},  -- High Chief's Pauldrons
	[14964]={s=21741},  -- High Chief's Shield
	[14965]={s=4450},  -- High Chief's Bindings
	[14966]={s=17801},  -- Glorious Breastplate
	[14967]={s=6867},  -- Glorious Gauntlets
	[14968]={s=6502},  -- Glorious Belt
	[14969]={s=12241},  -- Glorious Headdress
	[14970]={s=15598},  -- Glorious Legplates
	[14971]={s=11076},  -- Glorious Shoulder Pads
	[14972]={s=10486},  -- Glorious Sabatons
	[14973]={s=27810},  -- Glorious Shield
	[14974]={s=6009},  -- Glorious Bindings
	[14975]={s=20219},  -- Exalted Harness
	[14976]={s=8349},  -- Exalted Gauntlets
	[14977]={s=7982},  -- Exalted Girdle
	[14978]={s=13913},  -- Exalted Sabatons
	[14979]={s=14664},  -- Exalted Helmet
	[14980]={s=19201},  -- Exalted Legplates
	[14981]={s=13764},  -- Exalted Epaulets
	[14983]={s=7985},  -- Exalted Armsplints
	[15002]={s=0},  -- Nimboya's Pike
	[15003]={s=20},  -- Primal Belt
	[15004]={s=42},  -- Primal Boots
	[15005]={s=28},  -- Primal Bands
	[15006]={s=72},  -- Primal Buckler
	[15007]={s=24},  -- Primal Cape
	[15008]={s=37},  -- Primal Mitts
	[15009]={s=162},  -- Primal Leggings
	[15010]={s=163},  -- Primal Wraps
	[15011]={s=183},  -- Lupine Cord
	[15012]={s=296},  -- Lupine Slippers
	[15013]={s=86},  -- Lupine Cuffs
	[15014]={s=585},  -- Lupine Buckler
	[15015]={s=86},  -- Lupine Cloak
	[15016]={s=200},  -- Lupine Handwraps
	[15017]={s=611},  -- Lupine Leggings
	[15018]={s=706},  -- Lupine Vest
	[15019]={s=366},  -- Lupine Mantle
	[15042]={s=0},  -- Empty Termite Jar
	[15043]={s=0},  -- Plagueland Termites
	[15044]={s=0},  -- Barrel of Plagueland Termites
	[15045]={s=19938},  -- Green Dragonscale Breastplate
	[15046]={s=22482},  -- Green Dragonscale Leggings
	[15047]={s=29836},  -- Red Dragonscale Breastplate
	[15048]={s=24409},  -- Blue Dragonscale Breastplate
	[15049]={s=20543},  -- Blue Dragonscale Shoulders
	[15050]={s=26071},  -- Black Dragonscale Breastplate
	[15051]={s=21736},  -- Black Dragonscale Shoulders
	[15052]={s=31933},  -- Black Dragonscale Leggings
	[15053]={s=17275},  -- Volcanic Breastplate
	[15054]={s=14559},  -- Volcanic Leggings
	[15055]={s=16019},  -- Volcanic Shoulders
	[15056]={s=20966},  -- Stormshroud Armor
	[15057]={s=18728},  -- Stormshroud Pants
	[15058]={s=14692},  -- Stormshroud Shoulders
	[15059]={s=24776},  -- Living Breastplate
	[15060]={s=21277},  -- Living Leggings
	[15061]={s=13803},  -- Living Shoulders
	[15062]={s=25709},  -- Devilsaur Leggings
	[15063]={s=11701},  -- Devilsaur Gauntlets
	[15064]={s=19717},  -- Warbear Harness
	[15065]={s=22233},  -- Warbear Woolies
	[15066]={s=23650},  -- Ironfeather Breastplate
	[15067]={s=12758},  -- Ironfeather Shoulders
	[15068]={s=21835},  -- Frostsaber Tunic
	[15069]={s=17012},  -- Frostsaber Leggings
	[15070]={s=9504},  -- Frostsaber Gloves
	[15071]={s=11443},  -- Frostsaber Boots
	[15072]={s=16233},  -- Chimeric Leggings
	[15073]={s=11530},  -- Chimeric Boots
	[15074]={s=6867},  -- Chimeric Gloves
	[15075]={s=18449},  -- Chimeric Vest
	[15076]={s=16604},  -- Heavy Scorpid Vest
	[15077]={s=7615},  -- Heavy Scorpid Bracers
	[15078]={s=9649},  -- Heavy Scorpid Gauntlet
	[15079]={s=21760},  -- Heavy Scorpid Leggings
	[15080]={s=18230},  -- Heavy Scorpid Helm
	[15081]={s=20261},  -- Heavy Scorpid Shoulders
	[15082]={s=10375},  -- Heavy Scorpid Belt
	[15083]={s=6872},  -- Wicked Leather Gauntlets
	[15084]={s=7311},  -- Wicked Leather Bracers
	[15085]={s=22732},  -- Wicked Leather Armor
	[15086]={s=13154},  -- Wicked Leather Headband
	[15087]={s=17892},  -- Wicked Leather Pants
	[15088]={s=9901},  -- Wicked Leather Belt
	[15090]={s=22002},  -- Runic Leather Armor
	[15091]={s=7195},  -- Runic Leather Gauntlets
	[15092]={s=7656},  -- Runic Leather Bracers
	[15093]={s=8368},  -- Runic Leather Belt
	[15094]={s=14155},  -- Runic Leather Headband
	[15095]={s=20885},  -- Runic Leather Pants
	[15096]={s=17332},  -- Runic Leather Shoulders
	[15102]={s=0},  -- Un'Goro Tested Sample
	[15103]={s=0},  -- Corrupt Tested Sample
	[15104]={s=3188},  -- Wingborne Boots
	[15105]={s=14397},  -- Staff of Noh'Orahil
	[15106]={s=14447},  -- Staff of Dar'Orahil
	[15107]={s=5000},  -- Orb of Noh'Orahil
	[15108]={s=5000},  -- Orb of Dar'Orahil
	[15109]={s=3344},  -- Staff of Soran'ruk
	[15110]={s=351},  -- Rigid Belt
	[15111]={s=609},  -- Rigid Moccasins
	[15112]={s=354},  -- Rigid Bracelets
	[15113]={s=1361},  -- Rigid Buckler
	[15114]={s=372},  -- Rigid Cape
	[15115]={s=473},  -- Rigid Gloves
	[15116]={s=1163},  -- Rigid Shoulders
	[15117]={s=1219},  -- Rigid Leggings
	[15118]={s=1562},  -- Rigid Tunic
	[15119]={s=13683},  -- Highborne Pants
	[15120]={s=786},  -- Robust Girdle
	[15121]={s=1433},  -- Robust Boots
	[15122]={s=701},  -- Robust Bracers
	[15123]={s=2463},  -- Robust Buckler
	[15124]={s=847},  -- Robust Cloak
	[15125]={s=990},  -- Robust Gloves
	[15126]={s=1989},  -- Robust Leggings
	[15127]={s=1647},  -- Robust Shoulders
	[15128]={s=2425},  -- Robust Tunic
	[15129]={s=1825},  -- Robust Helm
	[15130]={s=3252},  -- Cutthroat's Vest
	[15131]={s=2023},  -- Cutthroat's Boots
	[15132]={s=1017},  -- Cutthroat's Armguards
	[15133]={s=3826},  -- Cutthroat's Buckler
	[15134]={s=3295},  -- Cutthroat's Hat
	[15135]={s=1357},  -- Cutthroat's Cape
	[15136]={s=1248},  -- Cutthroat's Belt
	[15137]={s=1516},  -- Cutthroat's Mitts
	[15138]={s=15198},  -- Onyxia Scale Cloak
	[15139]={s=3055},  -- Cutthroat's Loincloth
	[15140]={s=2529},  -- Cutthroat's Mantle
	[15142]={s=2603},  -- Ghostwalker Boots
	[15143]={s=1439},  -- Ghostwalker Bindings
	[15144]={s=4232},  -- Ghostwalker Rags
	[15145]={s=4943},  -- Ghostwalker Buckler
	[15146]={s=3730},  -- Ghostwalker Crown
	[15147]={s=1753},  -- Ghostwalker Cloak
	[15148]={s=1613},  -- Ghostwalker Belt
	[15149]={s=1960},  -- Ghostwalker Gloves
	[15150]={s=2951},  -- Ghostwalker Pads
	[15151]={s=3949},  -- Ghostwalker Legguards
	[15152]={s=4449},  -- Nocturnal Shoes
	[15153]={s=2626},  -- Nocturnal Cloak
	[15154]={s=2372},  -- Nocturnal Sash
	[15155]={s=2571},  -- Nocturnal Gloves
	[15156]={s=5266},  -- Nocturnal Cap
	[15157]={s=6200},  -- Nocturnal Leggings
	[15158]={s=4320},  -- Nocturnal Shoulder Pads
	[15159]={s=6743},  -- Nocturnal Tunic
	[15160]={s=2430},  -- Nocturnal Wristbands
	[15161]={s=3319},  -- Imposing Belt
	[15162]={s=5829},  -- Imposing Boots
	[15163]={s=3344},  -- Imposing Bracers
	[15164]={s=9135},  -- Imposing Vest
	[15165]={s=3744},  -- Imposing Cape
	[15166]={s=3945},  -- Imposing Gloves
	[15167]={s=7484},  -- Imposing Bandana
	[15168]={s=7951},  -- Imposing Pants
	[15169]={s=5542},  -- Imposing Shoulders
	[15170]={s=13103},  -- Potent Armor
	[15171]={s=8697},  -- Potent Boots
	[15172]={s=4706},  -- Potent Bands
	[15173]={s=5387},  -- Potent Cape
	[15174]={s=6017},  -- Potent Gloves
	[15175]={s=9692},  -- Potent Helmet
	[15176]={s=12121},  -- Potent Pants
	[15177]={s=8525},  -- Potent Shoulders
	[15178]={s=4935},  -- Potent Belt
	[15179]={s=18593},  -- Praetorian Padded Armor
	[15180]={s=6686},  -- Praetorian Girdle
	[15181]={s=11312},  -- Praetorian Boots
	[15182]={s=5996},  -- Praetorian Wristbands
	[15183]={s=6751},  -- Praetorian Cloak
	[15184]={s=7197},  -- Praetorian Gloves
	[15185]={s=12905},  -- Praetorian Coif
	[15186]={s=15373},  -- Praetorian Leggings
	[15187]={s=10918},  -- Praetorian Pauldrons
	[15188]={s=8702},  -- Grand Armguards
	[15189]={s=15722},  -- Grand Boots
	[15190]={s=9614},  -- Grand Cloak
	[15191]={s=9034},  -- Grand Belt
	[15192]={s=10595},  -- Grand Gauntlets
	[15193]={s=17586},  -- Grand Crown
	[15194]={s=22412},  -- Grand Legguards
	[15195]={s=23617},  -- Grand Breastplate
	[15196]={s=2500},  -- Private's Tabard
	[15197]={s=2500},  -- Scout's Tabard
	[15198]={s=10000},  -- Knight's Colors
	[15199]={s=10000},  -- Stone Guard's Herald
	[15200]={s=5000},  -- Senior Sergeant's Insignia
	[15202]={s=515},  -- Wildkeeper Leggings
	[15203]={s=621},  -- Guststorm Legguards
	[15204]={s=779},  -- Moonstone Wand
	[15205]={s=1063},  -- Owlsight Rifle
	[15206]={s=857},  -- Jadefinger Baton
	[15207]={s=868},  -- Steelcap Shield
	[15208]={s=0},  -- Cenarion Moondust
	[15209]={s=0},  -- Relic Bundle
	[15210]={s=825},  -- Raider Shortsword
	[15211]={s=1916},  -- Militant Shortsword
	[15212]={s=3450},  -- Fighter Broadsword
	[15213]={s=8165},  -- Mercenary Blade
	[15214]={s=11356},  -- Nobles Brand
	[15215]={s=16744},  -- Furious Falchion
	[15216]={s=25932},  -- Rune Sword
	[15217]={s=30996},  -- Widow Blade
	[15218]={s=37047},  -- Crystal Sword
	[15219]={s=41376},  -- Dimensional Blade
	[15220]={s=43493},  -- Battlefell Sabre
	[15221]={s=51946},  -- Holy War Sword
	[15222]={s=1219},  -- Barbed Club
	[15223]={s=2376},  -- Jagged Star
	[15224]={s=2695},  -- Battlesmasher
	[15225]={s=5958},  -- Sequoia Hammer
	[15226]={s=8755},  -- Giant Club
	[15227]={s=21925},  -- Diamond-Tip Bludgeon
	[15228]={s=28308},  -- Smashing Star
	[15229]={s=31924},  -- Blesswind Hammer
	[15230]={s=2755},  -- Ridge Cleaver
	[15231]={s=5033},  -- Splitting Hatchet
	[15232]={s=6112},  -- Hacking Cleaver
	[15233]={s=10476},  -- Savage Axe
	[15234]={s=11354},  -- Greater Scythe
	[15235]={s=21090},  -- Crescent Edge
	[15236]={s=27485},  -- Moon Cleaver
	[15237]={s=30526},  -- Corpse Harvester
	[15238]={s=36496},  -- Warlord's Axe
	[15239]={s=42409},  -- Felstone Reaver
	[15240]={s=49281},  -- Demon's Claw
	[15241]={s=3012},  -- Battle Knife
	[15242]={s=4426},  -- Honed Stiletto
	[15243]={s=7871},  -- Deadly Kris
	[15244]={s=12769},  -- Razor Blade
	[15245]={s=23284},  -- Vorpal Dagger
	[15246]={s=45704},  -- Demon Blade
	[15247]={s=50576},  -- Bloodstrike Dagger
	[15248]={s=1791},  -- Gleaming Claymore
	[15249]={s=3877},  -- Polished Zweihander
	[15250]={s=6894},  -- Glimmering Flamberge
	[15251]={s=17685},  -- Headstriker Sword
	[15252]={s=27906},  -- Tusker Sword
	[15253]={s=31547},  -- Beheading Blade
	[15254]={s=35584},  -- Dark Espadon
	[15255]={s=42545},  -- Gallant Flamberge
	[15256]={s=47531},  -- Massacre Sword
	[15257]={s=55234},  -- Shin Blade
	[15258]={s=64185},  -- Divine Warblade
	[15259]={s=3306},  -- Hefty Battlehammer
	[15260]={s=11556},  -- Stone Hammer
	[15261]={s=13530},  -- Sequoia Branch
	[15262]={s=21552},  -- Greater Maul
	[15263]={s=28889},  -- Royal Mallet
	[15264]={s=41517},  -- Backbreaker
	[15265]={s=46823},  -- Painbringer
	[15266]={s=54405},  -- Fierce Mauler
	[15267]={s=60203},  -- Brutehammer
	[15268]={s=1024},  -- Twin-bladed Axe
	[15269]={s=3036},  -- Massive Battle Axe
	[15270]={s=22775},  -- Gigantic War Axe
	[15271]={s=43701},  -- Colossal Great Axe
	[15272]={s=51740},  -- Razor Axe
	[15273]={s=57108},  -- Death Striker
	[15274]={s=31666},  -- Diviner Long Staff
	[15275]={s=35714},  -- Thaumaturgist Staff
	[15276]={s=45263},  -- Magus Long Staff
	[15277]={s=0},  -- Gray Kodo
	[15278]={s=50285},  -- Solstice Staff
	[15279]={s=18267},  -- Ivory Wand
	[15280]={s=20603},  -- Wizard's Hand
	[15281]={s=26110},  -- Glowstar Rod
	[15282]={s=30628},  -- Dragon Finger
	[15283]={s=37365},  -- Lunar Wand
	[15284]={s=3039},  -- Long Battle Bow
	[15285]={s=4061},  -- Archer's Longbow
	[15286]={s=5568},  -- Long Redwood Bow
	[15287]={s=12516},  -- Crusader Bow
	[15288]={s=33743},  -- Blasthorn Bow
	[15289]={s=41161},  -- Archstrike Bow
	[15290]={s=0},  -- Brown Kodo
	[15291]={s=19591},  -- Harpy Needler
	[15292]={s=0},  -- Green Kodo
	[15293]={s=0},  -- Teal Kodo
	[15294]={s=20135},  -- Siege Bow
	[15295]={s=22712},  -- Quillfire Bow
	[15296]={s=34657},  -- Hawkeye Bow
	[15297]={s=45},  -- Grizzly Bracers
	[15298]={s=305},  -- Grizzly Buckler
	[15299]={s=42},  -- Grizzly Cape
	[15300]={s=86},  -- Grizzly Gloves
	[15301]={s=108},  -- Grizzly Slippers
	[15302]={s=47},  -- Grizzly Belt
	[15303]={s=299},  -- Grizzly Pants
	[15304]={s=414},  -- Grizzly Jerkin
	[15305]={s=412},  -- Feral Shoes
	[15306]={s=208},  -- Feral Bindings
	[15307]={s=815},  -- Feral Buckler
	[15308]={s=241},  -- Feral Cord
	[15309]={s=220},  -- Feral Cloak
	[15310]={s=279},  -- Feral Gloves
	[15311]={s=982},  -- Feral Harness
	[15312]={s=745},  -- Feral Leggings
	[15313]={s=514},  -- Feral Shoulder Pads
	[15314]={s=0},  -- Bundle of Relics
	[15322]={s=7745},  -- Smoothbore Gun
	[15323]={s=17791},  -- Percussion Shotgun
	[15324]={s=25565},  -- Burnside Rifle
	[15325]={s=31784},  -- Sharpshooter Harquebus
	[15326]={s=1},  -- Gleaming Throwing Axe
	[15327]={s=1},  -- Wicked Throwing Dagger
	[15329]={s=622},  -- Wrangler's Belt
	[15330]={s=1059},  -- Wrangler's Boots
	[15331]={s=555},  -- Wrangler's Wristbands
	[15332]={s=2263},  -- Wrangler's Buckler
	[15333]={s=537},  -- Wrangler's Cloak
	[15334]={s=828},  -- Wrangler's Gloves
	[15335]={s=580},  -- Briarsteel Shortsword
	[15336]={s=1669},  -- Wrangler's Leggings
	[15337]={s=2027},  -- Wrangler's Wraps
	[15338]={s=1387},  -- Wrangler's Mantle
	[15339]={s=2466},  -- Pathfinder Hat
	[15340]={s=1016},  -- Pathfinder Cloak
	[15341]={s=1697},  -- Pathfinder Footpads
	[15342]={s=2907},  -- Pathfinder Guard
	[15343]={s=1139},  -- Pathfinder Gloves
	[15344]={s=2516},  -- Pathfinder Pants
	[15345]={s=1894},  -- Pathfinder Shoulder Pads
	[15346]={s=2788},  -- Pathfinder Vest
	[15347]={s=955},  -- Pathfinder Belt
	[15348]={s=792},  -- Pathfinder Bracers
	[15349]={s=1549},  -- Headhunter's Belt
	[15350]={s=2384},  -- Headhunter's Slippers
	[15351]={s=1090},  -- Headhunter's Bands
	[15352]={s=4101},  -- Headhunter's Buckler
	[15353]={s=3467},  -- Headhunter's Headdress
	[15354]={s=1600},  -- Headhunter's Cloak
	[15355]={s=1620},  -- Headhunter's Mitts
	[15356]={s=3935},  -- Headhunter's Armor
	[15357]={s=2693},  -- Headhunter's Spaulders
	[15358]={s=3604},  -- Headhunter's Woolies
	[15359]={s=5955},  -- Trickster's Vest
	[15360]={s=2372},  -- Trickster's Bindings
	[15361]={s=2204},  -- Trickster's Sash
	[15362]={s=3871},  -- Trickster's Boots
	[15363]={s=4894},  -- Trickster's Headdress
	[15364]={s=2431},  -- Trickster's Cloak
	[15365]={s=2415},  -- Trickster's Handwraps
	[15366]={s=5250},  -- Trickster's Leggings
	[15367]={s=6246},  -- Trickster's Protector
	[15368]={s=3674},  -- Trickster's Pauldrons
	[15369]={s=3097},  -- Wolf Rider's Belt
	[15370]={s=5439},  -- Wolf Rider's Boots
	[15371]={s=3467},  -- Wolf Rider's Cloak
	[15372]={s=3383},  -- Wolf Rider's Gloves
	[15373]={s=6930},  -- Wolf Rider's Headgear
	[15374]={s=7363},  -- Wolf Rider's Leggings
	[15375]={s=5132},  -- Wolf Rider's Shoulder Pads
	[15376]={s=8653},  -- Wolf Rider's Padded Armor
	[15377]={s=3191},  -- Wolf Rider's Wristbands
	[15378]={s=4358},  -- Rageclaw Belt
	[15379]={s=7654},  -- Rageclaw Boots
	[15380]={s=4390},  -- Rageclaw Bracers
	[15381]={s=12593},  -- Rageclaw Chestguard
	[15382]={s=5043},  -- Rageclaw Cloak
	[15383]={s=5313},  -- Rageclaw Gloves
	[15384]={s=9155},  -- Rageclaw Helm
	[15385]={s=11449},  -- Rageclaw Leggings
	[15386]={s=7287},  -- Rageclaw Shoulder Pads
	[15387]={s=5583},  -- Jadefire Bracelets
	[15388]={s=6357},  -- Jadefire Belt
	[15389]={s=10146},  -- Jadefire Sabatons
	[15390]={s=16175},  -- Jadefire Chestguard
	[15391]={s=12178},  -- Jadefire Cap
	[15392]={s=6382},  -- Jadefire Cloak
	[15393]={s=6479},  -- Jadefire Gloves
	[15394]={s=14614},  -- Jadefire Pants
	[15395]={s=10379},  -- Jadefire Epaulets
	[15396]={s=582},  -- Curvewood Dagger
	[15397]={s=731},  -- Oakthrush Staff
	[15398]={s=108},  -- Sandcomber Boots
	[15399]={s=151},  -- Dryweed Belt
	[15400]={s=109},  -- Clamshell Bracers
	[15401]={s=72},  -- Welldrip Gloves
	[15402]={s=109},  -- Noosegrip Gauntlets
	[15403]={s=279},  -- Ridgeback Bracers
	[15404]={s=337},  -- Breakwater Girdle
	[15405]={s=245},  -- Shucking Gloves
	[15406]={s=402},  -- Crustacean Boots
	[15407]={s=500},  -- Cured Rugged Hide
	[15408]={s=500},  -- Heavy Scorpid Scale
	[15409]={s=1000},  -- Refined Deeprock Salt
	[15410]={s=5000},  -- Scale of Onyxia
	[15411]={s=10283},  -- Mark of Fordring
	[15412]={s=500},  -- Green Dragonscale
	[15413]={s=22519},  -- Ornate Adamantium Breastplate
	[15414]={s=1500},  -- Red Dragonscale
	[15415]={s=500},  -- Blue Dragonscale
	[15416]={s=1000},  -- Black Dragonscale
	[15417]={s=500},  -- Devilsaur Leather
	[15418]={s=73597},  -- Shimmering Platinum Warhammer
	[15419]={s=600},  -- Warbear Leather
	[15420]={s=100},  -- Ironfeather
	[15421]={s=17855},  -- Shroud of the Exile
	[15422]={s=500},  -- Frostsaber Leather
	[15423]={s=500},  -- Chimera Leather
	[15424]={s=1404},  -- Axe of Orgrimmar
	[15425]={s=8272},  -- Peerless Bracers
	[15426]={s=13419},  -- Peerless Boots
	[15427]={s=8536},  -- Peerless Cloak
	[15428]={s=8024},  -- Peerless Belt
	[15429]={s=9049},  -- Peerless Gloves
	[15430]={s=15435},  -- Peerless Headband
	[15431]={s=19673},  -- Peerless Leggings
	[15432]={s=14104},  -- Peerless Shoulders
	[15433]={s=21849},  -- Peerless Armor
	[15434]={s=10964},  -- Supreme Sash
	[15435]={s=18199},  -- Supreme Shoes
	[15436]={s=10519},  -- Supreme Bracers
	[15437]={s=13301},  -- Supreme Cape
	[15438]={s=12264},  -- Supreme Gloves
	[15439]={s=19387},  -- Supreme Crown
	[15440]={s=24707},  -- Supreme Leggings
	[15441]={s=18595},  -- Supreme Shoulders
	[15442]={s=27433},  -- Supreme Breastplate
	[15443]={s=1119},  -- Kris of Orgrimmar
	[15444]={s=1404},  -- Staff of Orgrimmar
	[15445]={s=1127},  -- Hammer of Orgrimmar
	[15447]={s=0},  -- Living Rot
	[15448]={s=0},  -- Coagulated Rot
	[15449]={s=425},  -- Ghastly Trousers
	[15450]={s=533},  -- Dredgemire Leggings
	[15451]={s=643},  -- Gargoyle Leggings
	[15452]={s=215},  -- Featherbead Bracers
	[15453]={s=269},  -- Savannah Bracers
	[15454]={s=0},  -- Mortar and Pestle
	[15455]={s=3541},  -- Dustfall Robes
	[15456]={s=4442},  -- Lightstep Leggings
	[15457]={s=1134},  -- Desert Shoulders
	[15458]={s=1423},  -- Tundra Boots
	[15459]={s=1142},  -- Grimtoll Wristguards
	[15461]={s=841},  -- Lightheel Boots
	[15462]={s=653},  -- Loamflake Bracers
	[15463]={s=787},  -- Palestrider Gloves
	[15464]={s=4504},  -- Brute Hammer
	[15465]={s=2713},  -- Stingshot Wand
	[15466]={s=2323},  -- Clink Shield
	[15467]={s=8630},  -- Inventor's League Ring
	[15468]={s=1207},  -- Windsong Drape
	[15469]={s=1009},  -- Windsong Cinch
	[15470]={s=2432},  -- Plainsguard Leggings
	[15471]={s=2034},  -- Brawnhide Armor
	[15472]={s=33},  -- Charger's Belt
	[15473]={s=65},  -- Charger's Boots
	[15474]={s=23},  -- Charger's Bindings
	[15475]={s=24},  -- Charger's Cloak
	[15476]={s=44},  -- Charger's Handwraps
	[15477]={s=192},  -- Charger's Pants
	[15478]={s=52},  -- Charger's Shield
	[15479]={s=179},  -- Charger's Armor
	[15480]={s=84},  -- War Torn Girdle
	[15481]={s=127},  -- War Torn Greaves
	[15482]={s=54},  -- War Torn Bands
	[15483]={s=41},  -- War Torn Cape
	[15484]={s=68},  -- War Torn Handgrips
	[15485]={s=344},  -- War Torn Pants
	[15486]={s=245},  -- War Torn Shield
	[15487]={s=479},  -- War Torn Tunic
	[15488]={s=967},  -- Bloodspattered Surcoat
	[15489]={s=363},  -- Bloodspattered Sabatons
	[15490]={s=105},  -- Bloodspattered Cloak
	[15491]={s=211},  -- Bloodspattered Gloves
	[15492]={s=212},  -- Bloodspattered Sash
	[15493]={s=647},  -- Bloodspattered Loincloth
	[15494]={s=693},  -- Bloodspattered Shield
	[15495]={s=220},  -- Bloodspattered Wristbands
	[15496]={s=461},  -- Bloodspattered Shoulder Pads
	[15497]={s=387},  -- Outrunner's Cord
	[15498]={s=674},  -- Outrunner's Slippers
	[15499]={s=307},  -- Outrunner's Cuffs
	[15500]={s=1377},  -- Outrunner's Chestguard
	[15501]={s=269},  -- Outrunner's Cloak
	[15502]={s=411},  -- Outrunner's Gloves
	[15503]={s=1091},  -- Outrunner's Legguards
	[15504]={s=1168},  -- Outrunner's Shield
	[15505]={s=561},  -- Outrunner's Pauldrons
	[15506]={s=723},  -- Grunt's AnkleWraps
	[15507]={s=364},  -- Grunt's Bracers
	[15508]={s=365},  -- Grunt's Cape
	[15509]={s=485},  -- Grunt's Handwraps
	[15510]={s=423},  -- Grunt's Belt
	[15511]={s=1474},  -- Grunt's Legguards
	[15512]={s=1578},  -- Grunt's Shield
	[15513]={s=1264},  -- Grunt's Pauldrons
	[15514]={s=1902},  -- Grunt's Chestpiece
	[15515]={s=844},  -- Spiked Chain Belt
	[15516]={s=1587},  -- Spiked Chain Slippers
	[15517]={s=850},  -- Spiked Chain Wristbands
	[15518]={s=2825},  -- Spiked Chain Breastplate
	[15519]={s=607},  -- Spiked Chain Cloak
	[15520]={s=879},  -- Spiked Chain Gauntlets
	[15521]={s=1942},  -- Spiked Chain Leggings
	[15522]={s=2516},  -- Spiked Chain Shield
	[15523]={s=1474},  -- Spiked Chain Shoulder Pads
	[15524]={s=2876},  -- Sentry's Surcoat
	[15525]={s=1634},  -- Sentry's Slippers
	[15526]={s=704},  -- Sentry's Cape
	[15527]={s=1020},  -- Sentry's Gloves
	[15528]={s=930},  -- Sentry's Sash
	[15529]={s=2487},  -- Sentry's Leggings
	[15530]={s=3222},  -- Sentry's Shield
	[15531]={s=2076},  -- Sentry's Shoulderguards
	[15532]={s=944},  -- Sentry's Armsplints
	[15533]={s=2290},  -- Sentry's Headdress
	[15534]={s=2308},  -- Wicked Chain Boots
	[15535]={s=1270},  -- Wicked Chain Bracers
	[15536]={s=4107},  -- Wicked Chain Chestpiece
	[15537]={s=1163},  -- Wicked Chain Cloak
	[15538]={s=1412},  -- Wicked Chain Gauntlets
	[15539]={s=1282},  -- Wicked Chain Waistband
	[15540]={s=2827},  -- Wicked Chain Helmet
	[15541]={s=3441},  -- Wicked Chain Legguards
	[15542]={s=2365},  -- Wicked Chain Shoulder Pads
	[15543]={s=4179},  -- Wicked Chain Shield
	[15544]={s=2448},  -- Thick Scale Sabatons
	[15545]={s=1348},  -- Thick Scale Bracelets
	[15546]={s=4793},  -- Thick Scale Breastplate
	[15547]={s=1234},  -- Thick Scale Cloak
	[15548]={s=1649},  -- Thick Scale Gauntlets
	[15549]={s=1504},  -- Thick Scale Belt
	[15550]={s=3316},  -- Thick Scale Crown
	[15551]={s=4438},  -- Thick Scale Legguards
	[15552]={s=5226},  -- Thick Scale Shield
	[15553]={s=3061},  -- Thick Scale Shoulder Pads
	[15554]={s=1853},  -- Pillager's Girdle
	[15555]={s=2802},  -- Pillager's Boots
	[15556]={s=1697},  -- Pillager's Bracers
	[15557]={s=5486},  -- Pillager's Chestguard
	[15558]={s=4128},  -- Pillager's Crown
	[15559]={s=1450},  -- Pillager's Cloak
	[15560]={s=1937},  -- Pillager's Gloves
	[15561]={s=4705},  -- Pillager's Leggings
	[15562]={s=3558},  -- Pillager's Pauldrons
	[15563]={s=5562},  -- Pillager's Shield
	[15564]={s=1000},  -- Rugged Armor Kit
	[15565]={s=4274},  -- Marauder's Boots
	[15566]={s=2178},  -- Marauder's Bracers
	[15567]={s=6666},  -- Marauder's Tunic
	[15568]={s=1813},  -- Marauder's Cloak
	[15569]={s=7162},  -- Marauder's Crest
	[15570]={s=2431},  -- Marauder's Gauntlets
	[15571]={s=2218},  -- Marauder's Belt
	[15572]={s=4714},  -- Marauder's Circlet
	[15573]={s=5840},  -- Marauder's Leggings
	[15574]={s=5150},  -- Marauder's Shoulder Pads
	[15575]={s=2300},  -- Sparkleshell Belt
	[15576]={s=4462},  -- Sparkleshell Sabatons
	[15577]={s=2317},  -- Sparkleshell Bracers
	[15578]={s=6962},  -- Sparkleshell Breastplate
	[15579]={s=2122},  -- Sparkleshell Cloak
	[15580]={s=4871},  -- Sparkleshell Headwrap
	[15581]={s=2794},  -- Sparkleshell Gauntlets
	[15582]={s=6544},  -- Sparkleshell Legguards
	[15583]={s=5344},  -- Sparkleshell Shoulder Pads
	[15584]={s=7594},  -- Sparkleshell Shield
	[15585]={s=1446},  -- Pardoc Grips
	[15587]={s=1822},  -- Ringtail Girdle
	[15588]={s=2194},  -- Bracesteel Belt
	[15589]={s=5462},  -- Steadfast Stompers
	[15590]={s=2674},  -- Steadfast Bracelets
	[15591]={s=8739},  -- Steadfast Breastplate
	[15592]={s=8465},  -- Steadfast Buckler
	[15593]={s=5532},  -- Steadfast Coronet
	[15594]={s=2520},  -- Steadfast Cloak
	[15595]={s=2950},  -- Steadfast Gloves
	[15596]={s=6909},  -- Steadfast Legplates
	[15597]={s=5642},  -- Steadfast Shoulders
	[15598]={s=2763},  -- Steadfast Girdle
	[15599]={s=6631},  -- Ancient Greaves
	[15600]={s=3787},  -- Ancient Vambraces
	[15601]={s=10345},  -- Ancient Chestpiece
	[15602]={s=7211},  -- Ancient Crown
	[15603]={s=3546},  -- Ancient Cloak
	[15604]={s=11158},  -- Ancient Defender
	[15605]={s=3858},  -- Ancient Gauntlets
	[15606]={s=3585},  -- Ancient Belt
	[15607]={s=9305},  -- Ancient Legguards
	[15608]={s=7035},  -- Ancient Pauldrons
	[15609]={s=11806},  -- Bonelink Armor
	[15610]={s=4354},  -- Bonelink Bracers
	[15611]={s=4369},  -- Bonelink Cape
	[15612]={s=4285},  -- Bonelink Gauntlets
	[15613]={s=3688},  -- Bonelink Belt
	[15614]={s=7026},  -- Bonelink Sabatons
	[15615]={s=7584},  -- Bonelink Helmet
	[15616]={s=10151},  -- Bonelink Legplates
	[15617]={s=7107},  -- Bonelink Epaulets
	[15618]={s=11782},  -- Bonelink Wall Shield
	[15619]={s=5987},  -- Gryphon Mail Belt
	[15620]={s=5564},  -- Gryphon Mail Bracelets
	[15621]={s=15766},  -- Gryphon Mail Buckler
	[15622]={s=14834},  -- Gryphon Mail Breastplate
	[15623]={s=10715},  -- Gryphon Mail Crown
	[15624]={s=4971},  -- Gryphon Cloak
	[15625]={s=5818},  -- Gryphon Mail Gauntlets
	[15626]={s=8798},  -- Gryphon Mail Greaves
	[15627]={s=14493},  -- Gryphon Mail Legguards
	[15628]={s=9570},  -- Gryphon Mail Pauldrons
	[15629]={s=6374},  -- Formidable Bracers
	[15630]={s=10312},  -- Formidable Sabatons
	[15631]={s=16672},  -- Formidable Chestpiece
	[15632]={s=4997},  -- Formidable Cape
	[15633]={s=16210},  -- Formidable Crest
	[15634]={s=11441},  -- Formidable Circlet
	[15635]={s=5896},  -- Formidable Gauntlets
	[15636]={s=6333},  -- Formidable Belt
	[15637]={s=14557},  -- Formidable Legguards
	[15638]={s=9614},  -- Formidable Shoulder Pads
	[15639]={s=7040},  -- Ironhide Bracers
	[15640]={s=20233},  -- Ironhide Breastplate
	[15641]={s=7587},  -- Ironhide Belt
	[15642]={s=12162},  -- Ironhide Greaves
	[15643]={s=6675},  -- Ironhide Cloak
	[15644]={s=8130},  -- Ironhide Gauntlets
	[15645]={s=14577},  -- Ironhide Helmet
	[15646]={s=19506},  -- Ironhide Legguards
	[15647]={s=13125},  -- Ironhide Pauldrons
	[15648]={s=22212},  -- Ironhide Shield
	[15649]={s=7808},  -- Merciless Bracers
	[15650]={s=22230},  -- Merciless Surcoat
	[15651]={s=15785},  -- Merciless Crown
	[15652]={s=7139},  -- Merciless Cloak
	[15653]={s=8053},  -- Merciless Gauntlets
	[15654]={s=8569},  -- Merciless Belt
	[15655]={s=19862},  -- Merciless Legguards
	[15656]={s=13366},  -- Merciless Epaulets
	[15657]={s=22625},  -- Merciless Shield
	[15658]={s=17850},  -- Impenetrable Sabatons
	[15659]={s=9508},  -- Impenetrable Bindings
	[15660]={s=26315},  -- Impenetrable Breastplate
	[15661]={s=9036},  -- Impenetrable Cloak
	[15662]={s=10801},  -- Impenetrable Gauntlets
	[15663]={s=10226},  -- Impenetrable Belt
	[15664]={s=19071},  -- Impenetrable Helmet
	[15665]={s=25520},  -- Impenetrable Legguards
	[15666]={s=18375},  -- Impenetrable Pauldrons
	[15667]={s=28785},  -- Impenetrable Wall
	[15668]={s=11697},  -- Magnificent Bracers
	[15669]={s=28538},  -- Magnificent Breastplate
	[15670]={s=20455},  -- Magnificent Helmet
	[15671]={s=9782},  -- Magnificent Cloak
	[15672]={s=12164},  -- Magnificent Gauntlets
	[15673]={s=11075},  -- Magnificent Belt
	[15674]={s=18464},  -- Magnificent Greaves
	[15675]={s=28932},  -- Magnificent Guard
	[15676]={s=25928},  -- Magnificent Leggings
	[15677]={s=19605},  -- Magnificent Shoulders
	[15678]={s=21693},  -- Triumphant Sabatons
	[15679]={s=13108},  -- Triumphant Bracers
	[15680]={s=31983},  -- Triumphant Chestpiece
	[15681]={s=11406},  -- Triumphant Cloak
	[15682]={s=14610},  -- Triumphant Gauntlets
	[15683]={s=12666},  -- Triumphant Girdle
	[15684]={s=23178},  -- Triumphant Skullcap
	[15685]={s=29539},  -- Triumphant Legplates
	[15686]={s=22331},  -- Triumphant Shoulder Pads
	[15689]={s=4040},  -- Trader's Ring
	[15690]={s=4912},  -- Kodobone Necklace
	[15691]={s=6909},  -- Sidegunner Shottie
	[15692]={s=6763},  -- Kodo Brander
	[15693]={s=14533},  -- Grand Shoulders
	[15694]={s=13264},  -- Merciless Greaves
	[15695]={s=5771},  -- Studded Ring Shield
	[15696]={s=0},  -- Ruined Tome
	[15697]={s=2825},  -- Kodo Rustler Boots
	[15698]={s=4273},  -- Wrangling Spaulders
	[15699]={s=25},  -- Small Brown-wrapped Package
	[15702]={s=7396},  -- Chemist's Ring
	[15703]={s=9032},  -- Chemist's Smock
	[15704]={s=6145},  -- Hunter's Insignia Medal
	[15705]={s=33830},  -- Tidecrest Blade
	[15706]={s=33830},  -- Hunt Tracker Blade
	[15707]={s=7215},  -- Brantwood Sash
	[15708]={s=8965},  -- Blight Leather Gloves
	[15709]={s=7270},  -- Gearforge Girdle
	[15710]={s=0},  -- Cenarion Lunardust
	[15722]={s=0},  -- Spraggle's Canteen
	[15723]={s=2825},  -- Tea with Sugar
	[15724]={s=3000},  -- Pattern: Heavy Scorpid Bracers
	[15725]={s=3000},  -- Pattern: Wicked Leather Gauntlets
	[15726]={s=3000},  -- Pattern: Green Dragonscale Breastplate
	[15727]={s=3000},  -- Pattern: Heavy Scorpid Vest
	[15728]={s=3000},  -- Pattern: Wicked Leather Bracers
	[15729]={s=3000},  -- Pattern: Chimeric Gloves
	[15730]={s=3000},  -- Pattern: Red Dragonscale Breastplate
	[15731]={s=3500},  -- Pattern: Runic Leather Gauntlets
	[15732]={s=3500},  -- Pattern: Volcanic Leggings
	[15733]={s=3500},  -- Pattern: Green Dragonscale Leggings
	[15734]={s=3500},  -- Pattern: Living Shoulders
	[15735]={s=3500},  -- Pattern: Ironfeather Shoulders
	[15736]={s=0},  -- Smokey's Special Compound
	[15737]={s=4000},  -- Pattern: Chimeric Boots
	[15738]={s=4000},  -- Pattern: Heavy Scorpid Gauntlets
	[15739]={s=4000},  -- Pattern: Runic Leather Bracers
	[15740]={s=4000},  -- Pattern: Frostsaber Boots
	[15741]={s=4000},  -- Pattern: Stormshroud Pants
	[15742]={s=4000},  -- Pattern: Warbear Harness
	[15743]={s=5000},  -- Pattern: Heavy Scorpid Belt
	[15744]={s=5000},  -- Pattern: Wicked Leather Headband
	[15745]={s=5000},  -- Pattern: Runic Leather Belt
	[15746]={s=5000},  -- Pattern: Chimeric Leggings
	[15747]={s=5000},  -- Pattern: Frostsaber Leggings
	[15748]={s=5000},  -- Pattern: Heavy Scorpid Leggings
	[15749]={s=5000},  -- Pattern: Volcanic Breastplate
	[15750]={s=0},  -- Sceptre of Light
	[15751]={s=5000},  -- Pattern: Blue Dragonscale Breastplate
	[15752]={s=5000},  -- Pattern: Living Leggings
	[15753]={s=5000},  -- Pattern: Stormshroud Armor
	[15754]={s=5000},  -- Pattern: Warbear Woolies
	[15755]={s=5500},  -- Pattern: Chimeric Vest
	[15756]={s=5500},  -- Pattern: Runic Leather Headband
	[15757]={s=5500},  -- Pattern: Wicked Leather Pants
	[15758]={s=5500},  -- Pattern: Devilsaur Gauntlets
	[15759]={s=5500},  -- Pattern: Black Dragonscale Breastplate
	[15760]={s=5500},  -- Pattern: Ironfeather Breastplate
	[15761]={s=6250},  -- Pattern: Frostsaber Gloves
	[15762]={s=6250},  -- Pattern: Heavy Scorpid Helm
	[15763]={s=6250},  -- Pattern: Blue Dragonscale Shoulders
	[15764]={s=6250},  -- Pattern: Stormshroud Shoulders
	[15765]={s=7500},  -- Pattern: Runic Leather Pants
	[15766]={s=0},  -- Gem of the Serpent
	[15767]={s=0},  -- Hameya's Key
	[15768]={s=7500},  -- Pattern: Wicked Leather Belt
	[15770]={s=7500},  -- Pattern: Black Dragonscale Shoulders
	[15771]={s=7500},  -- Pattern: Living Breastplate
	[15772]={s=7500},  -- Pattern: Devilsaur Leggings
	[15773]={s=10000},  -- Pattern: Wicked Leather Armor
	[15774]={s=10000},  -- Pattern: Heavy Scorpid Shoulders
	[15775]={s=10000},  -- Pattern: Volcanic Shoulders
	[15776]={s=10000},  -- Pattern: Runic Leather Armor
	[15777]={s=15000},  -- Pattern: Runic Leather Shoulders
	[15778]={s=1250},  -- Mechanical Yeti
	[15779]={s=15000},  -- Pattern: Frostsaber Tunic
	[15781]={s=15000},  -- Pattern: Black Dragonscale Leggings
	[15782]={s=43142},  -- Beaststalker Blade
	[15783]={s=43292},  -- Beasthunter Dagger
	[15784]={s=11541},  -- Crystal Breeze Mantle
	[15785]={s=0},  -- Zaeldarr's Head
	[15786]={s=18826},  -- Fernpulse Jerkin
	[15787]={s=22592},  -- Willow Band Hauberk
	[15788]={s=0},  -- Everlook Report
	[15789]={s=9574},  -- Deep River Cloak
	[15790]={s=0},  -- Studies in Spirit Speaking
	[15791]={s=7172},  -- Turquoise Sash
	[15792]={s=14154},  -- Plow Wood Spaulders
	[15793]={s=50},  -- A Chewed Bone
	[15794]={s=39},  -- Ripped Ogre Loincloth
	[15795]={s=7631},  -- Emerald Mist Gauntlets
	[15796]={s=12063},  -- Seaspray Bracers
	[15797]={s=7530},  -- Shining Armplates
	[15798]={s=50},  -- Chipped Ogre Teeth
	[15799]={s=7108},  -- Heroic Commendation Medal
	[15800]={s=36082},  -- Intrepid Shortsword
	[15801]={s=35860},  -- Valiant Shortsword
	[15802]={s=11648},  -- Mooncloth Boots
	[15803]={s=0},  -- Book of the Ancients
	[15804]={s=9574},  -- Cerise Drape
	[15805]={s=14662},  -- Penelope's Rose
	[15806]={s=51273},  -- Mirah's Song
	[15807]={s=58},  -- Light Crossbow
	[15808]={s=728},  -- Fine Light Crossbow
	[15809]={s=2938},  -- Heavy Crossbow
	[15810]={s=2029},  -- Short Spear
	[15811]={s=5426},  -- Heavy Spear
	[15812]={s=9574},  -- Orchid Amice
	[15813]={s=10113},  -- Gold Link Belt
	[15814]={s=41911},  -- Hameya's Slayer
	[15815]={s=11860},  -- Hameya's Cloak
	[15822]={s=11290},  -- Shadowskin Spaulders
	[15823]={s=9191},  -- Bricksteel Gauntlets
	[15824]={s=15061},  -- Astoria Robes
	[15825]={s=19302},  -- Traphook Jerkin
	[15826]={s=0},  -- Curative Animal Salve
	[15827]={s=22592},  -- Jadescale Breastplate
	[15842]={s=0},  -- Empty Dreadmist Peak Sampler
	[15843]={s=0},  -- Filled Dreadmist Peak Sampler
	[15844]={s=0},  -- Empty Cliffspring Falls Sampler
	[15845]={s=0},  -- Filled Cliffspring Falls Sampler
	[15846]={s=7500},  -- Salt Shaker
	[15847]={s=0},  -- Quel'Thalas Registry
	[15848]={s=0},  -- Crate of Ghost Magnets
	[15849]={s=0},  -- Ghost-o-plasm
	[15850]={s=0},  -- Patch of Duskwing's Fur
	[15851]={s=0},  -- Lunar Fungus
	[15852]={s=0},  -- Kodo Horn
	[15853]={s=51418},  -- Windreaper
	[15854]={s=64502},  -- Dancing Sliver
	[15855]={s=7888},  -- Ring of Protection
	[15856]={s=8788},  -- Archlight Talisman
	[15857]={s=15335},  -- Magebane Scion
	[15858]={s=7530},  -- Freewind Gloves
	[15859]={s=11296},  -- Seapost Girdle
	[15860]={s=7907},  -- Blinkstrike Armguards
	[15861]={s=14969},  -- Swiftfoot Treads
	[15862]={s=28789},  -- Blitzcleaver
	[15863]={s=28896},  -- Grave Scepter
	[15864]={s=1947},  -- Condor Bracers
	[15865]={s=6562},  -- Anchorhold Buckler
	[15866]={s=562},  -- Veildust Medicine Bag
	[15867]={s=7464},  -- Prismcharm
	[15868]={s=0},  -- The Grand Crusader's Command
	[15869]={s=50},  -- Silver Skeleton Key
	[15870]={s=300},  -- Golden Skeleton Key
	[15871]={s=625},  -- Truesilver Skeleton Key
	[15872]={s=625},  -- Arcanite Skeleton Key
	[15873]={s=8144},  -- Ragged John's Neverending Cup
	[15874]={s=0},  -- Soft-shelled Clam
	[15875]={s=0},  -- Rotten Apple
	[15876]={s=0},  -- Nathanos' Chest
	[15877]={s=0},  -- Shrine Bauble
	[15878]={s=0},  -- Rackmore's Silver Key
	[15879]={s=0},  -- Overlord Ror's Claw
	[15880]={s=0},  -- Head of Ramstein the Gorger
	[15881]={s=0},  -- Rackmore's Golden Key
	[15882]={s=0},  -- Half Pendant of Aquatic Endurance
	[15883]={s=0},  -- Half Pendant of Aquatic Agility
	[15884]={s=0},  -- Augustus' Receipt Book
	[15885]={s=0},  -- Pendant of the Sea Lion
	[15886]={s=0},  -- Timolain's Phylactery
	[15887]={s=29581},  -- Heroic Guard
	[15890]={s=25831},  -- Vanguard Shield
	[15891]={s=2014},  -- Hulking Shield
	[15892]={s=3582},  -- Slayer's Shield
	[15893]={s=1082},  -- Prospector's Buckler
	[15894]={s=1802},  -- Bristlebark Buckler
	[15895]={s=53},  -- Burnt Buckler
	[15902]={s=20000},  -- A Crazy Grab Bag
	[15903]={s=1623},  -- Right-Handed Claw
	[15904]={s=4341},  -- Right-Handed Blades
	[15905]={s=426},  -- Right-Handed Brass Knuckles
	[15906]={s=427},  -- Left-Handed Brass Knuckles
	[15907]={s=1647},  -- Left-Handed Claw
	[15908]={s=0},  -- Taming Rod
	[15909]={s=4421},  -- Left-Handed Blades
	[15911]={s=0},  -- Taming Rod
	[15912]={s=1148},  -- Buccaneer's Orb
	[15913]={s=0},  -- Taming Rod
	[15914]={s=0},  -- Taming Rod
	[15915]={s=0},  -- Taming Rod
	[15916]={s=0},  -- Taming Rod
	[15917]={s=0},  -- Taming Rod
	[15918]={s=4848},  -- Conjurer's Sphere
	[15919]={s=0},  -- Taming Rod
	[15920]={s=0},  -- Taming Rod
	[15921]={s=0},  -- Taming Rod
	[15922]={s=0},  -- Taming Rod
	[15923]={s=0},  -- Taming Rod
	[15924]={s=0},  -- Soft-shelled Clam Meat
	[15925]={s=439},  -- Journeyman's Stave
	[15926]={s=802},  -- Spellbinder Orb
	[15927]={s=1864},  -- Bright Sphere
	[15928]={s=2387},  -- Silver-thread Rod
	[15929]={s=4396},  -- Nightsky Orb
	[15930]={s=9146},  -- Imperial Red Scepter
	[15931]={s=10646},  -- Arcane Star
	[15932]={s=527},  -- Disciple's Stein
	[15933]={s=620},  -- Simple Branch
	[15934]={s=2596},  -- Sage's Stave
	[15935]={s=3323},  -- Durable Rod
	[15936]={s=8950},  -- Duskwoven Branch
	[15937]={s=7922},  -- Hibernal Sphere
	[15938]={s=9550},  -- Mystical Orb
	[15939]={s=10455},  -- Councillor's Scepter
	[15940]={s=10957},  -- Elegant Scepter
	[15941]={s=12345},  -- High Councillor's Scepter
	[15942]={s=12757},  -- Master's Rod
	[15943]={s=27752},  -- Imbued Shield
	[15944]={s=512},  -- Ancestral Orb
	[15945]={s=837},  -- Runic Stave
	[15946]={s=802},  -- Mystic's Sphere
	[15947]={s=1887},  -- Sanguine Star
	[15962]={s=2716},  -- Satyr's Rod
	[15963]={s=4887},  -- Stonecloth Branch
	[15964]={s=6364},  -- Silksand Star
	[15965]={s=7996},  -- Windchaser Orb
	[15966]={s=9137},  -- Venomshroud Orb
	[15967]={s=10304},  -- Highborne Star
	[15969]={s=425},  -- Beaded Orb
	[15970]={s=587},  -- Native Branch
	[15971]={s=1064},  -- Aboriginal Rod
	[15972]={s=1171},  -- Ritual Stein
	[15973]={s=2313},  -- Watcher's Star
	[15974]={s=1461},  -- Pagan Rod
	[15975]={s=2421},  -- Raincaller Scepter
	[15976]={s=4146},  -- Thistlefur Branch
	[15977]={s=4614},  -- Vital Orb
	[15978]={s=5385},  -- Geomancer's Rod
	[15979]={s=7215},  -- Embersilk Stave
	[15980]={s=7469},  -- Darkmist Orb
	[15981]={s=7215},  -- Lunar Sphere
	[15982]={s=8142},  -- Bloodwoven Rod
	[15983]={s=8387},  -- Gaea's Scepter
	[15984]={s=9614},  -- Opulent Scepter
	[15985]={s=9887},  -- Arachnidian Branch
	[15986]={s=10813},  -- Bonecaster's Star
	[15987]={s=10996},  -- Astral Orb
	[15988]={s=12471},  -- Resplendent Orb
	[15989]={s=12498},  -- Eternal Rod
	[15990]={s=6850},  -- Enduring Shield
	[15991]={s=29230},  -- Warleader's Shield
	[15992]={s=250},  -- Dense Blasting Powder
	[15993]={s=1500},  -- Thorium Grenade
	[15994]={s=2500},  -- Thorium Widget
	[15995]={s=19739},  -- Thorium Rifle
	[15996]={s=2500},  -- Lifelike Mechanical Toad
	[15997]={s=10},  -- Thorium Shells
	[15998]={s=0},  -- Lewis' Note
	[15999]={s=9002},  -- Spellpower Goggles Xtreme Plus
	[16000]={s=3750},  -- Thorium Tube
	[16001]={s=0},  -- SI:7 Insignia (Fredo)
	[16002]={s=0},  -- SI:7 Insignia (Turyen)
	[16003]={s=0},  -- SI:7 Insignia (Rutger)
	[16004]={s=29152},  -- Dark Iron Rifle
	[16005]={s=1250},  -- Dark Iron Bomb
	[16006]={s=10000},  -- Delicate Arcanite Converter
	[16007]={s=40625},  -- Flawless Arcanite Rifle
	[16008]={s=11739},  -- Master Engineer's Goggles
	[16009]={s=5930},  -- Voice Amplification Modulator
	[16022]={s=40000},  -- Arcanite Mechanical Dragonling
	[16023]={s=10000},  -- Masterwork Target Dummy
	[16039]={s=53598},  -- Ta'Kierthan Songblade
	[16040]={s=4000},  -- Arcane Bomb
	[16041]={s=3000},  -- Schematic: Thorium Grenade
	[16042]={s=3000},  -- Schematic: Thorium Widget
	[16043]={s=3000},  -- Schematic: Thorium Rifle
	[16044]={s=4000},  -- Schematic: Lifelike Mechanical Toad
	[16045]={s=4000},  -- Schematic: Spellpower Goggles Xtreme Plus
	[16046]={s=4000},  -- Schematic: Masterwork Target Dummy
	[16047]={s=4000},  -- Schematic: Thorium Tube
	[16048]={s=4000},  -- Schematic: Dark Iron Rifle
	[16049]={s=5000},  -- Schematic: Dark Iron Bomb
	[16050]={s=5000},  -- Schematic: Delicate Arcanite Converter
	[16051]={s=5000},  -- Schematic: Thorium Shells
	[16052]={s=5000},  -- Schematic: Voice Amplification Modulator
	[16053]={s=5000},  -- Schematic: Master Engineer's Goggles
	[16054]={s=6000},  -- Schematic: Arcanite Dragonling
	[16055]={s=6000},  -- Schematic: Arcane Bomb
	[16056]={s=6000},  -- Schematic: Flawless Arcanite Rifle
	[16058]={s=10156},  -- Fordring's Seal
	[16059]={s=100},  -- Common Brown Shirt
	[16060]={s=100},  -- Common White Shirt
	[16072]={s=2500},  -- Expert Cookbook
	[16083]={s=2500},  -- Expert Fishing - The Bass and You
	[16084]={s=2500},  -- Expert First Aid - Under Wraps
	[16110]={s=3000},  -- Recipe: Monster Omelet
	[16111]={s=3000},  -- Recipe: Spiced Chili Crab
	[16112]={s=550},  -- Manual: Heavy Silk Bandage
	[16113]={s=1250},  -- Manual: Mageweave Bandage
	[16114]={s=0},  -- Foreman's Blackjack
	[16115]={s=0},  -- Osric's Crate
	[16166]={s=1},  -- Bean Soup
	[16167]={s=6},  -- Versicolor Treat
	[16168]={s=100},  -- Heaven Peach
	[16169]={s=62},  -- Wild Ricecake
	[16170]={s=25},  -- Steamed Mandu
	[16171]={s=200},  -- Shinsollo
	[16189]={s=0},  -- Maggran's Reserve Letter
	[16190]={s=0},  -- Bloodfury Ripper's Remains
	[16192]={s=0},  -- Besseleth's Fang
	[16202]={s=0},  -- Lesser Eternal Essence
	[16203]={s=0},  -- Greater Eternal Essence
	[16204]={s=0},  -- Illusion Dust
	[16205]={s=0},  -- Gaea Seed
	[16206]={s=1000},  -- Arcanite Rod
	[16207]={s=1250},  -- Runed Arcanite Rod
	[16208]={s=0},  -- Enchanted Gaea Seeds
	[16209]={s=0},  -- Podrig's Order
	[16210]={s=0},  -- Gordon's Crate
	[16214]={s=3000},  -- Formula: Enchant Bracer - Greater Intellect
	[16215]={s=3000},  -- Formula: Enchant Boots - Greater Stamina
	[16216]={s=3000},  -- Formula: Enchant Cloak - Greater Resistance
	[16217]={s=3000},  -- Formula: Enchant Shield - Greater Stamina
	[16218]={s=3500},  -- Formula: Enchant Bracer - Superior Spirit
	[16219]={s=3500},  -- Formula: Enchant Gloves - Greater Agility
	[16220]={s=4000},  -- Formula: Enchant Boots - Spirit
	[16221]={s=4000},  -- Formula: Enchant Chest - Major Health
	[16222]={s=5000},  -- Formula: Enchant Shield - Superior Spirit
	[16223]={s=5000},  -- Formula: Enchant Weapon - Icy Chill
	[16224]={s=5000},  -- Formula: Enchant Cloak - Superior Defense
	[16242]={s=5500},  -- Formula: Enchant Chest - Major Mana
	[16243]={s=5500},  -- Formula: Runed Arcanite Rod
	[16244]={s=6000},  -- Formula: Enchant Gloves - Greater Strength
	[16245]={s=6000},  -- Formula: Enchant Boots - Greater Agility
	[16246]={s=6000},  -- Formula: Enchant Bracer - Superior Strength
	[16247]={s=6000},  -- Formula: Enchant Weapon - Superior Impact
	[16248]={s=6000},  -- Formula: Enchant Weapon - Unholy
	[16249]={s=7500},  -- Formula: Enchant 2H Weapon - Major Intellect
	[16250]={s=7500},  -- Formula: Enchant Weapon - Superior Striking
	[16251]={s=7500},  -- Formula: Enchant Bracer - Superior Stamina
	[16252]={s=7500},  -- Formula: Enchant Weapon - Crusader
	[16254]={s=7500},  -- Formula: Enchant Weapon - Lifestealing
	[16255]={s=7500},  -- Formula: Enchant 2H Weapon - Major Spirit
	[16262]={s=0},  -- Nessa's Collection
	[16263]={s=0},  -- Laird's Response
	[16282]={s=0},  -- Bundle of Hides
	[16283]={s=0},  -- Ahanu's Leather Goods
	[16302]={s=25},  -- Grimoire of Firebolt (Rank 2)
	[16303]={s=0},  -- Ursangous's Paw
	[16304]={s=0},  -- Shadumbra's Head
	[16305]={s=0},  -- Sharptalon's Claw
	[16306]={s=0},  -- Zargh's Meats
	[16307]={s=0},  -- Gryshka's Letter
	[16309]={s=0},  -- Drakefire Amulet
	[16310]={s=0},  -- Brock's List
	[16311]={s=0},  -- Honorary Picks
	[16312]={s=0},  -- Incendrites
	[16313]={s=0},  -- Felix's Chest
	[16314]={s=0},  -- Felix's Bucket of Bolts
	[16316]={s=375},  -- Grimoire of Firebolt (Rank 3)
	[16317]={s=1250},  -- Grimoire of Firebolt (Rank 4)
	[16318]={s=2500},  -- Grimoire of Firebolt (Rank 5)
	[16319]={s=3500},  -- Grimoire of Firebolt (Rank 6)
	[16320]={s=6000},  -- Grimoire of Firebolt (Rank 7)
	[16321]={s=25},  -- Grimoire of Blood Pact (Rank 1)
	[16322]={s=225},  -- Grimoire of Blood Pact (Rank 2)
	[16323]={s=1000},  -- Grimoire of Blood Pact (Rank 3)
	[16324]={s=2500},  -- Grimoire of Blood Pact (Rank 4)
	[16325]={s=3750},  -- Grimoire of Blood Pact (Rank 5)
	[16326]={s=225},  -- Grimoire of Fire Shield (Rank 1)
	[16327]={s=750},  -- Grimoire of Fire Shield (Rank 2)
	[16328]={s=2000},  -- Grimoire of Fire Shield (Rank 3)
	[16329]={s=3000},  -- Grimoire of Fire Shield (Rank 4)
	[16330]={s=5000},  -- Grimoire of Fire Shield (Rank 5)
	[16331]={s=150},  -- Grimoire of Phase Shift
	[16332]={s=0},  -- Thazz'ril's Pick
	[16333]={s=0},  -- Samuel's Remains
	[16335]={s=10000},  -- Senior Sergeant's Insignia
	[16341]={s=4285},  -- Sergeant's Cloak
	[16342]={s=8830},  -- Sergeant's Cape
	[16345]={s=30378},  -- High Warlord's Blade
	[16346]={s=500},  -- Grimoire of Torment (Rank 2)
	[16347]={s=1500},  -- Grimoire of Torment (Rank 3)
	[16348]={s=2750},  -- Grimoire of Torment (Rank 4)
	[16349]={s=3750},  -- Grimoire of Torment (Rank 5)
	[16350]={s=6500},  -- Grimoire of Torment (Rank 6)
	[16351]={s=300},  -- Grimoire of Sacrifice (Rank 1)
	[16352]={s=750},  -- Grimoire of Sacrifice (Rank 2)
	[16353]={s=1750},  -- Grimoire of Sacrifice (Rank 3)
	[16354]={s=2750},  -- Grimoire of Sacrifice (Rank 4)
	[16355]={s=3500},  -- Grimoire of Sacrifice (Rank 5)
	[16356]={s=5500},  -- Grimoire of Sacrifice (Rank 6)
	[16357]={s=375},  -- Grimoire of Consume Shadows (Rank 1)
	[16358]={s=1000},  -- Grimoire of Consume Shadows (Rank 2)
	[16359]={s=2000},  -- Grimoire of Consume Shadows (Rank 3)
	[16360]={s=2750},  -- Grimoire of Consume Shadows (Rank 4)
	[16361]={s=3750},  -- Grimoire of Consume Shadows (Rank 5)
	[16362]={s=6000},  -- Grimoire of Consume Shadows (Rank 6)
	[16363]={s=750},  -- Grimoire of Suffering (Rank 1)
	[16364]={s=2250},  -- Grimoire of Suffering (Rank 2)
	[16365]={s=3500},  -- Grimoire of Suffering (Rank 3)
	[16366]={s=6500},  -- Grimoire of Suffering (Rank 4)
	[16368]={s=1250},  -- Grimoire of Lash of Pain (Rank 2)
	[16369]={s=8416},  -- Knight-Lieutenant's Silk Boots
	[16371]={s=2250},  -- Grimoire of Lash of Pain (Rank 3)
	[16372]={s=3000},  -- Grimoire of Lash of Pain (Rank 4)
	[16373]={s=4500},  -- Grimoire of Lash of Pain (Rank 5)
	[16374]={s=6500},  -- Grimoire of Lash of Pain (Rank 6)
	[16375]={s=625},  -- Grimoire of Soothing Kiss (Rank 1)
	[16376]={s=2000},  -- Grimoire of Soothing Kiss (Rank 2)
	[16377]={s=3250},  -- Grimoire of Soothing Kiss (Rank 3)
	[16378]={s=6000},  -- Grimoire of Soothing Kiss (Rank 4)
	[16379]={s=1000},  -- Grimoire of Seduction
	[16380]={s=1750},  -- Grimoire of Lesser Invisibility
	[16381]={s=2500},  -- Grimoire of Devour Magic (Rank 2)
	[16382]={s=3250},  -- Grimoire of Devour Magic (Rank 3)
	[16383]={s=5000},  -- Grimoire of Devour Magic (Rank 4)
	[16384]={s=1750},  -- Grimoire of Tainted Blood (Rank 1)
	[16385]={s=2750},  -- Grimoire of Tainted Blood (Rank 2)
	[16386]={s=3500},  -- Grimoire of Tainted Blood (Rank 3)
	[16387]={s=5500},  -- Grimoire of Tainted Blood (Rank 4)
	[16388]={s=2250},  -- Grimoire of Spell Lock (Rank 1)
	[16389]={s=4500},  -- Grimoire of Spell Lock (Rank 2)
	[16390]={s=2750},  -- Grimoire of Paranoia
	[16391]={s=5652},  -- Knight-Lieutenant's Silk Gloves
	[16392]={s=10638},  -- Knight-Lieutenant's Leather Boots
	[16393]={s=10676},  -- Knight-Lieutenant's Dragonhide Footwraps
	[16396]={s=7388},  -- Knight-Lieutenant's Leather Gauntlets
	[16397]={s=7414},  -- Knight-Lieutenant's Dragonhide Gloves
	[16401]={s=13596},  -- Knight-Lieutenant's Chain Boots
	[16403]={s=8223},  -- Knight-Lieutenant's Chain Gauntlets
	[16405]={s=8286},  -- Knight-Lieutenant's Plate Boots
	[16406]={s=5545},  -- Knight-Lieutenant's Plate Gauntlets
	[16408]={s=0},  -- Befouled Water Globe
	[16409]={s=8413},  -- Knight-Lieutenant's Lamellar Sabatons
	[16410]={s=5630},  -- Knight-Lieutenant's Lamellar Gauntlets
	[16413]={s=11692},  -- Knight-Captain's Silk Raiment
	[16414]={s=11735},  -- Knight-Captain's Silk Leggings
	[16415]={s=8833},  -- Lieutenant Commander's Silk Spaulders
	[16416]={s=8864},  -- Lieutenant Commander's Crown
	[16417]={s=14827},  -- Knight-Captain's Leather Armor
	[16418]={s=11160},  -- Lieutenant Commander's Leather Veil
	[16419]={s=14934},  -- Knight-Captain's Leather Legguards
	[16420]={s=11239},  -- Lieutenant Commander's Leather Spaulders
	[16421]={s=15039},  -- Knight-Captain's Dragonhide Tunic
	[16422]={s=15092},  -- Knight-Captain's Dragonhide Leggings
	[16423]={s=10278},  -- Lieutenant Commander's Dragonhide Epaulets
	[16424]={s=10317},  -- Lieutenant Commander's Dragonhide Shroud
	[16425]={s=16571},  -- Knight-Captain's Chain Hauberk
	[16426]={s=16635},  -- Knight-Captain's Chain Leggings
	[16427]={s=12923},  -- Lieutenant Commander's Chain Pauldrons
	[16428]={s=12914},  -- Lieutenant Commander's Chain Helmet
	[16429]={s=8641},  -- Lieutenant Commander's Plate Helm
	[16430]={s=11564},  -- Knight-Captain's Plate Chestguard
	[16431]={s=11606},  -- Knight-Captain's Plate Leggings
	[16432]={s=8736},  -- Lieutenant Commander's Plate Pauldrons
	[16433]={s=11691},  -- Knight-Captain's Lamellar Breastplate
	[16434]={s=8800},  -- Lieutenant Commander's Lamellar Headguard
	[16435]={s=11775},  -- Knight-Captain's Lamellar Leggings
	[16436]={s=8863},  -- Lieutenant Commander's Lamellar Shoulders
	[16437]={s=13076},  -- Marshal's Silk Footwraps
	[16440]={s=8810},  -- Marshal's Silk Gloves
	[16441]={s=13263},  -- Field Marshal's Coronet
	[16442]={s=17745},  -- Marshal's Silk Leggings
	[16443]={s=16561},  -- Field Marshal's Silk Vestments
	[16444]={s=12468},  -- Field Marshal's Silk Spaulders
	[16446]={s=15701},  -- Marshal's Leather Footguards
	[16448]={s=10545},  -- Marshal's Dragonhide Gauntlets
	[16449]={s=15877},  -- Field Marshal's Dragonhide Spaulders
	[16450]={s=21246},  -- Marshal's Dragonhide Legguards
	[16451]={s=15993},  -- Field Marshal's Dragonhide Helmet
	[16452]={s=21402},  -- Field Marshal's Dragonhide Breastplate
	[16453]={s=21481},  -- Field Marshal's Leather Chestpiece
	[16454]={s=10778},  -- Marshal's Leather Handgrips
	[16455]={s=16226},  -- Field Marshal's Leather Mask
	[16456]={s=21713},  -- Marshal's Leather Leggings
	[16457]={s=16342},  -- Field Marshal's Leather Epaulets
	[16459]={s=15291},  -- Marshal's Dragonhide Boots
	[16462]={s=18642},  -- Marshal's Chain Boots
	[16463]={s=12420},  -- Marshal's Chain Grips
	[16465]={s=18769},  -- Field Marshal's Chain Helm
	[16466]={s=25119},  -- Field Marshal's Chain Breastplate
	[16467]={s=25213},  -- Marshal's Chain Legguards
	[16468]={s=19065},  -- Field Marshal's Chain Spaulders
	[16471]={s=8528},  -- Marshal's Lamellar Gloves
	[16472]={s=12839},  -- Marshal's Lamellar Boots
	[16473]={s=17181},  -- Field Marshal's Lamellar Chestplate
	[16474]={s=12933},  -- Field Marshal's Lamellar Faceguard
	[16475]={s=17755},  -- Marshal's Lamellar Legplates
	[16476]={s=12091},  -- Field Marshal's Lamellar Pauldrons
	[16477]={s=16184},  -- Field Marshal's Plate Armor
	[16478]={s=12185},  -- Field Marshal's Plate Helm
	[16479]={s=16309},  -- Marshal's Plate Legguards
	[16480]={s=12277},  -- Field Marshal's Plate Shoulderguards
	[16483]={s=12418},  -- Marshal's Plate Boots
	[16484]={s=8309},  -- Marshal's Plate Gauntlets
	[16485]={s=8511},  -- Blood Guard's Silk Footwraps
	[16486]={s=5695},  -- First Sergeant's Silk Cuffs
	[16487]={s=5716},  -- Blood Guard's Silk Gloves
	[16489]={s=8638},  -- Champion's Silk Hood
	[16490]={s=11560},  -- Legionnaire's Silk Pants
	[16491]={s=11906},  -- Legionnaire's Silk Robes
	[16492]={s=8962},  -- Champion's Silk Shoulderpads
	[16494]={s=11282},  -- Blood Guard's Dragonhide Boots
	[16496]={s=6853},  -- Blood Guard's Dragonhide Gauntlets
	[16497]={s=6880},  -- First Sergeant's Leather Armguards
	[16498]={s=10360},  -- Blood Guard's Leather Treads
	[16499]={s=6932},  -- Blood Guard's Leather Vices
	[16501]={s=10479},  -- Champion's Dragonhide Spaulders
	[16502]={s=14025},  -- Legionnaire's Dragonhide Trousers
	[16503]={s=10558},  -- Champion's Dragonhide Helm
	[16504]={s=14130},  -- Legionnaire's Dragonhide Breastplate
	[16505]={s=14184},  -- Legionnaire's Leather Hauberk
	[16506]={s=10676},  -- Champion's Leather Headguard
	[16507]={s=11002},  -- Champion's Leather Mantle
	[16508]={s=14723},  -- Legionnaire's Leather Leggings
	[16509]={s=8866},  -- Blood Guard's Plate Boots
	[16510]={s=5931},  -- Blood Guard's Plate Gloves
	[16513]={s=11991},  -- Legionnaire's Plate Armor
	[16514]={s=9024},  -- Champion's Plate Headguard
	[16515]={s=12075},  -- Legionnaire's Plate Legguards
	[16516]={s=8223},  -- Champion's Plate Pauldrons
	[16518]={s=12485},  -- Blood Guard's Mail Walkers
	[16519]={s=8318},  -- Blood Guard's Mail Grips
	[16521]={s=12572},  -- Champion's Mail Helm
	[16522]={s=16827},  -- Legionnaire's Mail Chestpiece
	[16523]={s=17349},  -- Legionnaire's Mail Legguards
	[16524]={s=13117},  -- Champion's Mail Shoulders
	[16525]={s=17475},  -- Legionnaire's Chain Breastplate
	[16526]={s=13154},  -- Champion's Chain Headguard
	[16527]={s=17603},  -- Legionnaire's Chain Leggings
	[16528]={s=13309},  -- Champion's Chain Pauldrons
	[16530]={s=8896},  -- Blood Guard's Chain Gauntlets
	[16531]={s=13452},  -- Blood Guard's Chain Boots
	[16532]={s=8960},  -- First Sergeant's Mail Wristguards
	[16533]={s=13217},  -- Warlord's Silk Cowl
	[16534]={s=17686},  -- General's Silk Trousers
	[16535]={s=17748},  -- Warlord's Silk Raiment
	[16536]={s=12087},  -- Warlord's Silk Amice
	[16539]={s=12563},  -- General's Silk Boots
	[16540]={s=8406},  -- General's Silk Handguards
	[16541]={s=16875},  -- Warlord's Plate Armor
	[16542]={s=12703},  -- Warlord's Plate Headpiece
	[16543]={s=17000},  -- General's Plate Leggings
	[16544]={s=12795},  -- Warlord's Plate Shoulders
	[16545]={s=12842},  -- General's Plate Boots
	[16548]={s=8655},  -- General's Plate Gauntlets
	[16549]={s=21716},  -- Warlord's Dragonhide Hauberk
	[16550]={s=16345},  -- Warlord's Dragonhide Helmet
	[16551]={s=16404},  -- Warlord's Dragonhide Epaulets
	[16552]={s=21948},  -- General's Dragonhide Leggings
	[16554]={s=16579},  -- General's Dragonhide Boots
	[16555]={s=10312},  -- General's Dragonhide Gloves
	[16558]={s=15644},  -- General's Leather Treads
	[16560]={s=10506},  -- General's Leather Mitts
	[16561]={s=15818},  -- Warlord's Leather Helm
	[16562]={s=15877},  -- Warlord's Leather Spaulders
	[16563]={s=21246},  -- Warlord's Leather Breastplate
	[16564]={s=21324},  -- General's Leather Legguards
	[16565]={s=25683},  -- Warlord's Chain Chestpiece
	[16566]={s=19333},  -- Warlord's Chain Helmet
	[16567]={s=25868},  -- General's Chain Legguards
	[16568]={s=19558},  -- Warlord's Chain Shoulders
	[16569]={s=19629},  -- General's Chain Boots
	[16571]={s=12186},  -- General's Chain Gloves
	[16573]={s=18502},  -- General's Mail Boots
	[16574]={s=12326},  -- General's Mail Gauntlets
	[16577]={s=24934},  -- Warlord's Mail Armor
	[16578]={s=18769},  -- Warlord's Mail Helm
	[16579]={s=25119},  -- General's Mail Leggings
	[16580]={s=18994},  -- Warlord's Mail Spaulders
	[16581]={s=0},  -- Resonite Crystal
	[16583]={s=2500},  -- Demonic Figurine
	[16602]={s=0},  -- Troll Charm
	[16603]={s=0},  -- Enchanted Resonite Crystal
	[16604]={s=17},  -- Moon Robes of Elune
	[16605]={s=17},  -- Friar's Robes of the Light
	[16606]={s=17},  -- Juju Hex Robes
	[16607]={s=16},  -- Acolyte's Sacrificial Robes
	[16608]={s=193},  -- Aquarius Belt
	[16622]={s=27307},  -- Thornflinger
	[16623]={s=7783},  -- Opaline Medallion
	[16642]={s=0},  -- Shredder Operating Manual - Chapter 1
	[16643]={s=0},  -- Shredder Operating Manual - Chapter 2
	[16644]={s=0},  -- Shredder Operating Manual - Chapter 3
	[16645]={s=62},  -- Shredder Operating Manual - Page 1
	[16646]={s=62},  -- Shredder Operating Manual - Page 2
	[16647]={s=62},  -- Shredder Operating Manual - Page 3
	[16648]={s=62},  -- Shredder Operating Manual - Page 4
	[16649]={s=62},  -- Shredder Operating Manual - Page 5
	[16650]={s=62},  -- Shredder Operating Manual - Page 6
	[16651]={s=62},  -- Shredder Operating Manual - Page 7
	[16652]={s=62},  -- Shredder Operating Manual - Page 8
	[16653]={s=62},  -- Shredder Operating Manual - Page 9
	[16654]={s=62},  -- Shredder Operating Manual - Page 10
	[16655]={s=62},  -- Shredder Operating Manual - Page 11
	[16656]={s=62},  -- Shredder Operating Manual - Page 12
	[16658]={s=1649},  -- Wildhunter Cloak
	[16659]={s=856},  -- Deftkin Belt
	[16660]={s=2200},  -- Driftmire Shield
	[16661]={s=965},  -- Soft Willow Cape
	[16662]={s=0},  -- Fragment of the Dragon's Eye
	[16663]={s=0},  -- Blood of the Black Dragon Champion
	[16665]={s=0},  -- Tome of Tranquilizing Shot
	[16666]={s=35962},  -- Vest of Elements
	[16667]={s=25778},  -- Coif of Elements
	[16668]={s=30541},  -- Kilt of Elements
	[16669]={s=21995},  -- Pauldrons of Elements
	[16670]={s=21027},  -- Boots of Elements
	[16671]={s=12586},  -- Bindings of Elements
	[16672]={s=14059},  -- Gauntlets of Elements
	[16673]={s=13440},  -- Cord of Elements
	[16674]={s=34435},  -- Beaststalker's Tunic
	[16675]={s=21421},  -- Beaststalker's Boots
	[16676]={s=14268},  -- Beaststalker's Gloves
	[16677]={s=24868},  -- Beaststalker's Cap
	[16678]={s=31694},  -- Beaststalker's Pants
	[16679]={s=22822},  -- Beaststalker's Mantle
	[16680]={s=13788},  -- Beaststalker's Belt
	[16681]={s=13055},  -- Beaststalker's Bindings
	[16682]={s=14582},  -- Magister's Boots
	[16683]={s=8765},  -- Magister's Bindings
	[16684]={s=9093},  -- Magister's Gloves
	[16685]={s=8694},  -- Magister's Belt
	[16686]={s=15912},  -- Magister's Crown
	[16687]={s=20281},  -- Magister's Leggings
	[16688]={s=22445},  -- Magister's Robes
	[16689]={s=14597},  -- Magister's Mantle
	[16690]={s=22616},  -- Devout Robe
	[16691]={s=14005},  -- Devout Sandals
	[16692]={s=9372},  -- Devout Gloves
	[16693]={s=16335},  -- Devout Crown
	[16694]={s=20820},  -- Devout Skirt
	[16695]={s=14925},  -- Devout Mantle
	[16696]={s=9058},  -- Devout Belt
	[16697]={s=8577},  -- Devout Bracers
	[16698]={s=16636},  -- Dreadmist Mask
	[16699]={s=21202},  -- Dreadmist Leggings
	[16700]={s=24071},  -- Dreadmist Robe
	[16701]={s=15650},  -- Dreadmist Mantle
	[16702]={s=8592},  -- Dreadmist Belt
	[16703]={s=8138},  -- Dreadmist Bracers
	[16704]={s=13639},  -- Dreadmist Sandals
	[16705]={s=9127},  -- Dreadmist Wraps
	[16706]={s=27841},  -- Wildheart Vest
	[16707]={s=19962},  -- Shadowcraft Cap
	[16708]={s=18175},  -- Shadowcraft Spaulders
	[16709]={s=25542},  -- Shadowcraft Pants
	[16710]={s=10446},  -- Shadowcraft Bracers
	[16711]={s=17505},  -- Shadowcraft Boots
	[16712]={s=11714},  -- Shadowcraft Gloves
	[16713]={s=11196},  -- Shadowcraft Belt
	[16714]={s=10602},  -- Wildheart Bracers
	[16715]={s=17766},  -- Wildheart Boots
	[16716]={s=11620},  -- Wildheart Belt
	[16717]={s=12244},  -- Wildheart Gloves
	[16718]={s=19354},  -- Wildheart Spaulders
	[16719]={s=27192},  -- Wildheart Kilt
	[16720]={s=21490},  -- Wildheart Cowl
	[16721]={s=30190},  -- Shadowcraft Tunic
	[16722]={s=8105},  -- Lightforge Bracers
	[16723]={s=8625},  -- Lightforge Belt
	[16724]={s=9091},  -- Lightforge Gauntlets
	[16725]={s=13688},  -- Lightforge Boots
	[16726]={s=22270},  -- Lightforge Breastplate
	[16727]={s=15968},  -- Lightforge Helm
	[16728]={s=20354},  -- Lightforge Legplates
	[16729]={s=14592},  -- Lightforge Spaulders
	[16730]={s=22609},  -- Breastplate of Valor
	[16731]={s=16210},  -- Helm of Valor
	[16732]={s=21213},  -- Legplates of Valor
	[16733]={s=15207},  -- Spaulders of Valor
	[16734]={s=14536},  -- Boots of Valor
	[16735]={s=8738},  -- Bracers of Valor
	[16736]={s=9295},  -- Belt of Valor
	[16737]={s=9794},  -- Gauntlets of Valor
	[16738]={s=3893},  -- Witherseed Gloves
	[16739]={s=7300},  -- Rugwood Mantle
	[16740]={s=942},  -- Shredder Operating Gloves
	[16741]={s=1178},  -- Oilrag Handwraps
	[16742]={s=0},  -- Warsong Saw Blades
	[16743]={s=0},  -- Logging Rope
	[16744]={s=0},  -- Warsong Oil
	[16745]={s=0},  -- Warsong Axe Shipment
	[16746]={s=0},  -- Warsong Report
	[16747]={s=27},  -- Broken Lock
	[16748]={s=15},  -- Padded Lining
	[16762]={s=0},  -- Fathom Core
	[16763]={s=0},  -- Warsong Runner Update
	[16764]={s=0},  -- Warsong Scout Update
	[16765]={s=0},  -- Warsong Outrider Update
	[16766]={s=100},  -- Undermine Clam Chowder
	[16767]={s=750},  -- Recipe: Undermine Clam Chowder
	[16768]={s=37500},  -- Furbolg Medicine Pouch
	[16769]={s=26616},  -- Furbolg Medicine Totem
	[16782]={s=0},  -- Strange Water Globe
	[16783]={s=0},  -- Bundle of Reports
	[16784]={s=0},  -- Sapphire of Aku'Mai
	[16785]={s=0},  -- Rexxar's Testament
	[16786]={s=0},  -- Black Dragonspawn Eye
	[16787]={s=0},  -- Amulet of Draconic Subversion
	[16788]={s=5095},  -- Captain Rackmore's Wheel
	[16789]={s=5692},  -- Captain Rackmore's Tiller
	[16790]={s=0},  -- Damp Note
	[16791]={s=1912},  -- Silkstream Cuffs
	[16793]={s=4353},  -- Arcmetal Shoulders
	[16794]={s=2705},  -- Gripsteel Wristguards
	[16795]={s=27359},  -- Arcanist Crown
	[16796]={s=33990},  -- Arcanist Leggings
	[16797]={s=25591},  -- Arcanist Mantle
	[16798]={s=34253},  -- Arcanist Robes
	[16799]={s=17192},  -- Arcanist Bindings
	[16800]={s=25885},  -- Arcanist Boots
	[16801]={s=17322},  -- Arcanist Gloves
	[16802]={s=17388},  -- Arcanist Belt
	[16803]={s=26180},  -- Felheart Slippers
	[16804]={s=17517},  -- Felheart Bracers
	[16805]={s=17583},  -- Felheart Gloves
	[16806]={s=17649},  -- Felheart Belt
	[16807]={s=26572},  -- Felheart Shoulder Pads
	[16808]={s=26668},  -- Felheart Skullcap
	[16809]={s=35690},  -- Felheart Robes
	[16810]={s=35821},  -- Felheart Pants
	[16811]={s=26962},  -- Boots of Prophecy
	[16812]={s=18040},  -- Gloves of Prophecy
	[16813]={s=27866},  -- Circlet of Prophecy
	[16814]={s=37286},  -- Pants of Prophecy
	[16815]={s=33855},  -- Robes of Prophecy
	[16816]={s=25490},  -- Mantle of Prophecy
	[16817]={s=17059},  -- Girdle of Prophecy
	[16818]={s=27895},  -- Netherwind Belt
	[16819]={s=17189},  -- Vambraces of Prophecy
	[16820]={s=43137},  -- Nightslayer Chestpiece
	[16821]={s=32476},  -- Nightslayer Cover
	[16822]={s=43465},  -- Nightslayer Pants
	[16823]={s=32719},  -- Nightslayer Shoulder Pads
	[16824]={s=32842},  -- Nightslayer Boots
	[16825]={s=21977},  -- Nightslayer Bracelets
	[16826]={s=22057},  -- Nightslayer Gloves
	[16827]={s=22139},  -- Nightslayer Belt
	[16828]={s=22221},  -- Cenarion Belt
	[16829]={s=34339},  -- Cenarion Boots
	[16830]={s=22972},  -- Cenarion Bracers
	[16831]={s=23055},  -- Cenarion Gloves
	[16832]={s=56532},  -- Bloodfang Spaulders
	[16833]={s=46439},  -- Cenarion Vestments
	[16834]={s=34949},  -- Cenarion Helm
	[16835]={s=42315},  -- Cenarion Leggings
	[16836]={s=31859},  -- Cenarion Spaulders
	[16837]={s=38550},  -- Earthfury Boots
	[16838]={s=25682},  -- Earthfury Belt
	[16839]={s=25781},  -- Earthfury Gauntlets
	[16840]={s=25879},  -- Earthfury Bracers
	[16841]={s=51956},  -- Earthfury Breastplate
	[16842]={s=39111},  -- Earthfury Helmet
	[16843]={s=52345},  -- Earthfury Legguards
	[16844]={s=39582},  -- Earthfury Epaulets
	[16845]={s=54148},  -- Giantstalker's Breastplate
	[16846]={s=40759},  -- Giantstalker's Helmet
	[16847]={s=54543},  -- Giantstalker's Leggings
	[16848]={s=41237},  -- Giantstalker's Epaulets
	[16849]={s=41382},  -- Giantstalker's Boots
	[16850]={s=27564},  -- Giantstalker's Bracers
	[16851]={s=27663},  -- Giantstalker's Belt
	[16852]={s=27762},  -- Giantstalker's Gloves
	[16853]={s=37144},  -- Lawbringer Chestguard
	[16854]={s=27956},  -- Lawbringer Helm
	[16855]={s=33848},  -- Lawbringer Legplates
	[16856]={s=25485},  -- Lawbringer Spaulders
	[16857]={s=17053},  -- Lawbringer Bracers
	[16858]={s=17119},  -- Lawbringer Belt
	[16859]={s=25778},  -- Lawbringer Boots
	[16860]={s=17249},  -- Lawbringer Gauntlets
	[16861]={s=17786},  -- Bracers of Might
	[16862]={s=26778},  -- Sabatons of Might
	[16863]={s=17917},  -- Gauntlets of Might
	[16864]={s=17981},  -- Belt of Might
	[16865]={s=36095},  -- Breastplate of Might
	[16866]={s=27170},  -- Helm of Might
	[16867]={s=36358},  -- Legplates of Might
	[16868]={s=27364},  -- Pauldrons of Might
	[16869]={s=0},  -- The Skull of Scryer
	[16870]={s=0},  -- The Skull of Somnus
	[16871]={s=0},  -- The Skull of Chronalis
	[16872]={s=0},  -- The Skull of Axtroz
	[16873]={s=2254},  -- Braidfur Gloves
	[16882]={s=0},  -- Battered Junkbox
	[16883]={s=0},  -- Worn Junkbox
	[16884]={s=0},  -- Sturdy Junkbox
	[16885]={s=0},  -- Heavy Junkbox
	[16886]={s=5492},  -- Outlaw Sabre
	[16887]={s=1988},  -- Witch's Finger
	[16888]={s=0},  -- Dull Drakefire Amulet
	[16889]={s=3093},  -- Polished Walking Staff
	[16890]={s=2483},  -- Slatemetal Cutlass
	[16891]={s=1697},  -- Claystone Shortsword
	[16892]={s=0},  -- Lesser Soulstone
	[16893]={s=0},  -- Soulstone
	[16894]={s=1993},  -- Clear Crystal Rod
	[16895]={s=0},  -- Greater Soulstone
	[16896]={s=0},  -- Major Soulstone
	[16898]={s=53709},  -- Stormrage Boots
	[16900]={s=54111},  -- Stormrage Cover
	[16902]={s=54507},  -- Stormrage Pauldrons
	[16906]={s=55305},  -- Bloodfang Boots
	[16907]={s=37004},  -- Bloodfang Gloves
	[16908]={s=55707},  -- Bloodfang Hood
	[16909]={s=69209},  -- Bloodfang Pants
	[16910]={s=34738},  -- Bloodfang Belt
	[16911]={s=34872},  -- Bloodfang Bracers
	[16913]={s=28109},  -- Netherwind Gloves
	[16914]={s=42324},  -- Netherwind Crown
	[16915]={s=56647},  -- Netherwind Pants
	[16917]={s=42802},  -- Netherwind Mantle
	[16919]={s=43123},  -- Boots of Transcendence
	[16920]={s=28856},  -- Handguards of Transcendence
	[16921]={s=43440},  -- Halo of Transcendence
	[16922]={s=58135},  -- Leggings of Transcendence
	[16925]={s=30153},  -- Belt of Transcendence
	[16926]={s=30260},  -- Bindings of Transcendence
	[16928]={s=27573},  -- Nemesis Gloves
	[16929]={s=41521},  -- Nemesis Skullcap
	[16932]={s=41998},  -- Nemesis Spaulders
	[16934]={s=28213},  -- Nemesis Bracers
	[16936]={s=42637},  -- Dragonstalker's Belt
	[16937]={s=64482},  -- Dragonstalker's Spaulders
	[16938]={s=85917},  -- Dragonstalker's Legguards
	[16939]={s=64672},  -- Dragonstalker's Helm
	[16940]={s=43275},  -- Dragonstalker's Gauntlets
	[16941]={s=67178},  -- Dragonstalker's Greaves
	[16943]={s=44904},  -- Bracers of Ten Storms
	[16944]={s=45065},  -- Belt of Ten Storms
	[16947]={s=68314},  -- Helmet of Ten Storms
	[16949]={s=62551},  -- Greaves of Ten Storms
	[16951]={s=27889},  -- Judgement Bindings
	[16952]={s=27996},  -- Judgement Belt
	[16954]={s=56415},  -- Judgement Legplates
	[16955]={s=42472},  -- Judgement Crown
	[16957]={s=43944},  -- Judgement Sabatons
	[16959]={s=29507},  -- Bracelets of Wrath
	[16960]={s=29614},  -- Waistband of Wrath
	[16962]={s=59652},  -- Legplates of Wrath
	[16963]={s=44900},  -- Helm of Wrath
	[16964]={s=30040},  -- Gauntlets of Wrath
	[16967]={s=0},  -- Feralas Ahi
	[16968]={s=0},  -- Sar'theris Striker
	[16969]={s=0},  -- Savage Coast Blue Sailfin
	[16970]={s=0},  -- Misty Reed Mahi Mahi
	[16971]={s=300},  -- Clamlette Surprise
	[16972]={s=0},  -- Karang's Banner
	[16973]={s=0},  -- Vial of Dire Water
	[16974]={s=0},  -- Empty Water Vial
	[16975]={s=813},  -- Warsong Sash
	[16976]={s=0},  -- Murgut's Totem
	[16977]={s=1448},  -- Warsong Boots
	[16978]={s=1158},  -- Warsong Gauntlets
	[16979]={s=14901},  -- Flarecore Gloves
	[16980]={s=21365},  -- Flarecore Mantle
	[16981]={s=271},  -- Owlbeard Bracers
	[16982]={s=24397},  -- Corehound Boots
	[16983]={s=25709},  -- Molten Helm
	[16984]={s=32653},  -- Black Dragonscale Boots
	[16985]={s=847},  -- Windseeker Boots
	[16986]={s=850},  -- Sandspire Gloves
	[16987]={s=884},  -- Screecher Belt
	[16988]={s=31460},  -- Fiery Chain Shoulders
	[16989]={s=18610},  -- Fiery Chain Girdle
	[16990]={s=998},  -- Spritekin Cloak
	[16991]={s=0},  -- Triage Bandage
	[16992]={s=30874},  -- Smokey's Explosive Launcher
	[16993]={s=30989},  -- Smokey's Fireshooter
	[16994]={s=9884},  -- Duskwing Gloves
	[16995]={s=14826},  -- Duskwing Mantle
	[16996]={s=41451},  -- Gorewood Bow
	[16997]={s=41603},  -- Stormrager
	[16998]={s=35631},  -- Sacred Protector
	[16999]={s=10709},  -- Royal Seal of Alexis
	[17001]={s=10314},  -- Elemental Circle
	[17002]={s=44825},  -- Ichor Spitter
	[17003]={s=44982},  -- Skullstone Hammer
	[17004]={s=56429},  -- Sarah's Guide
	[17005]={s=1632},  -- Boorguard Tunic
	[17006]={s=1966},  -- Cobalt Legguards
	[17007]={s=11447},  -- Stonerender Gauntlets
	[17008]={s=0},  -- Small Scroll
	[17009]={s=0},  -- Ambassador Malcin's Head
	[17010]={s=2000},  -- Fiery Core
	[17011]={s=2000},  -- Lava Core
	[17012]={s=1000},  -- Core Leather
	[17013]={s=26441},  -- Dark Iron Leggings
	[17014]={s=12637},  -- Dark Iron Bracers
	[17015]={s=63738},  -- Dark Iron Reaver
	[17016]={s=63973},  -- Dark Iron Destroyer
	[17017]={s=45000},  -- Pattern: Flarecore Mantle
	[17018]={s=20000},  -- Pattern: Flarecore Gloves
	[17020]={s=250},  -- Arcane Powder
	[17021]={s=175},  -- Wild Berries
	[17022]={s=37500},  -- Pattern: Corehound Boots
	[17023]={s=40000},  -- Pattern: Molten Helm
	[17025]={s=40000},  -- Pattern: Black Dragonscale Boots
	[17026]={s=250},  -- Wild Thornroot
	[17028]={s=175},  -- Holy Candle
	[17029]={s=250},  -- Sacred Candle
	[17030]={s=500},  -- Ankh
	[17031]={s=250},  -- Rune of Teleportation
	[17032]={s=500},  -- Rune of Portals
	[17033]={s=500},  -- Symbol of Divinity
	[17034]={s=50},  -- Maple Seed
	[17035]={s=100},  -- Stranglethorn Seed
	[17036]={s=200},  -- Ashwood Seed
	[17037]={s=350},  -- Hornbeam Seed
	[17038]={s=500},  -- Ironwood Seed
	[17039]={s=8317},  -- Skullbreaker
	[17042]={s=5692},  -- Nail Spitter
	[17043]={s=3054},  -- Zealot's Robe
	[17044]={s=15038},  -- Will of the Martyr
	[17045]={s=14846},  -- Blood of the Martyr
	[17046]={s=4796},  -- Gutterblade
	[17047]={s=1313},  -- Luminescent Amice
	[17048]={s=400},  -- Rumsey Rum
	[17049]={s=22500},  -- Plans: Fiery Chain Girdle
	[17050]={s=12536},  -- Chan's Imperial Robes
	[17051]={s=17500},  -- Plans: Dark Iron Bracers
	[17052]={s=45000},  -- Plans: Dark Iron Leggings
	[17053]={s=50000},  -- Plans: Fiery Chain Shoulders
	[17054]={s=28788},  -- Joonho's Mercy
	[17055]={s=26747},  -- Changuk Smasher
	[17056]={s=7},  -- Light Feather
	[17057]={s=7},  -- Shiny Fish Scales
	[17058]={s=7},  -- Fish Oil
	[17059]={s=55000},  -- Plans: Dark Iron Reaver
	[17060]={s=55000},  -- Plans: Dark Iron Destroyer
	[17062]={s=550},  -- Recipe: Mithril Head Trout
	[17063]={s=23961},  -- Band of Accuria
	[17064]={s=45914},  -- Shard of the Scale
	[17065]={s=33381},  -- Medallion of Steadfast Might
	[17066]={s=57970},  -- Drillborer Disk
	[17067]={s=75452},  -- Ancient Cornerstone Grimoire
	[17068]={s=78833},  -- Deathbringer
	[17069]={s=62316},  -- Striker's Mark
	[17070]={s=109307},  -- Fang of the Mystics
	[17071]={s=104472},  -- Gutgore Ripper
	[17072]={s=61616},  -- Blastershot Launcher
	[17073]={s=113631},  -- Earthshaker
	[17074]={s=98514},  -- Shadowstrike
	[17075]={s=79087},  -- Vis'kag the Bloodletter
	[17076]={s=196438},  -- Bonereaver's Edge
	[17077]={s=56896},  -- Crimson Shocker
	[17078]={s=23981},  -- Sapphiron Drape
	[17102]={s=38689},  -- Cloak of the Shrouded Mists
	[17103]={s=111823},  -- Azuresong Mageblade
	[17105]={s=102178},  -- Aurastone Hammer
	[17106]={s=87960},  -- Malistar's Defender
	[17107]={s=37537},  -- Dragon's Blood Cape
	[17109]={s=33625},  -- Choker of Enlightenment
	[17110]={s=24648},  -- Seal of the Archmagus
	[17111]={s=34648},  -- Blazefury Medallion
	[17112]={s=90558},  -- Empyrean Demolisher
	[17113]={s=119278},  -- Amberseal Keeper
	[17114]={s=0},  -- Araj's Phylactery Shard
	[17117]={s=0},  -- Rat Catcher's Flute
	[17118]={s=0},  -- Carton of Mystery Meat
	[17119]={s=6},  -- Deeprun Rat Kabob
	[17124]={s=0},  -- Syndicate Emblem
	[17125]={s=0},  -- Seal of Ravenholdt
	[17126]={s=0},  -- Elegant Letter
	[17183]={s=6},  -- Dented Buckler
	[17184]={s=6},  -- Small Shield
	[17185]={s=48},  -- Round Buckler
	[17186]={s=48},  -- Small Targe
	[17187]={s=215},  -- Banded Buckler
	[17188]={s=453},  -- Ringed Buckler
	[17189]={s=2408},  -- Metal Buckler
	[17190]={s=6921},  -- Ornate Buckler
	[17191]={s=0},  -- Scepter of Celebras
	[17192]={s=879},  -- Reinforced Targe
	[17193]={s=122310},  -- Sulfuron Hammer
	[17194]={s=0},  -- Holiday Spices
	[17195]={s=0},  -- Mistletoe
	[17196]={s=12},  -- Holiday Spirits
	[17197]={s=10},  -- Gingerbread Cookie
	[17198]={s=9},  -- Egg Nog
	[17200]={s=6},  -- Recipe: Gingerbread Cookie
	[17201]={s=60},  -- Recipe: Egg Nog
	[17202]={s=0},  -- Snowball
	[17203]={s=100000},  -- Sulfuron Ingot
	[17222]={s=300},  -- Spider Sausage
	[17223]={s=97074},  -- Thunderstrike
	[17242]={s=0},  -- Key to Salem's Chest
	[17262]={s=0},  -- James' Key
	[17303]={s=2},  -- Blue Ribboned Wrapping Paper
	[17304]={s=2},  -- Green Ribboned Wrapping Paper
	[17306]={s=0},  -- Stormpike Soldier's Blood
	[17307]={s=2},  -- Purple Ribboned Wrapping Paper
	[17309]={s=0},  -- Discordant Bracers
	[17310]={s=0},  -- Aspect of Neptulos
	[17322]={s=0},  -- Eye of the Emberseer
	[17326]={s=0},  -- Stormpike Soldier's Flesh
	[17327]={s=0},  -- Stormpike Lieutenant's Flesh
	[17328]={s=0},  -- Stormpike Commander's Flesh
	[17329]={s=0},  -- Hand of Lucifron
	[17330]={s=0},  -- Hand of Sulfuron
	[17331]={s=0},  -- Hand of Gehennas
	[17332]={s=0},  -- Hand of Shazzrah
	[17333]={s=0},  -- Aqual Quintessence
	[17344]={s=1},  -- Candy Cane
	[17345]={s=0},  -- Silithid Goo
	[17346]={s=0},  -- Encrusted Silithid Object
	[17355]={s=0},  -- Rabine's Letter
	[17402]={s=500},  -- Greatfather's Winter Ale
	[17403]={s=37},  -- Steamwheedle Fizzy Spirits
	[17404]={s=6},  -- Blended Bean Brew
	[17405]={s=50},  -- Green Garden Tea
	[17406]={s=6},  -- Holiday Cheesewheel
	[17407]={s=50},  -- Graccu's Homemade Meat Pie
	[17408]={s=100},  -- Spicy Beefstick
	[17413]={s=7750},  -- Codex: Prayer of Fortitude
	[17414]={s=14750},  -- Codex: Prayer of Fortitude II
	[17422]={s=2},  -- Armor Scraps
	[17508]={s=7270},  -- Forcestone Buckler
	[17523]={s=10758},  -- Smokey's Drape
	[17562]={s=8736},  -- Knight-Lieutenant's Dreadweave Boots
	[17564]={s=5866},  -- Knight-Lieutenant's Dreadweave Gloves
	[17566]={s=8863},  -- Lieutenant Commander's Headguard
	[17567]={s=11860},  -- Knight-Captain's Dreadweave Leggings
	[17568]={s=11054},  -- Knight-Captain's Dreadweave Robe
	[17569]={s=8322},  -- Lieutenant Commander's Dreadweave Mantle
	[17570]={s=8354},  -- Champion's Dreadweave Hood
	[17571]={s=11182},  -- Legionnaire's Dreadweave Leggings
	[17572]={s=11223},  -- Legionnaire's Dreadweave Robe
	[17573]={s=8449},  -- Champion's Dreadweave Shoulders
	[17576]={s=8544},  -- Blood Guard's Dreadweave Boots
	[17577]={s=5717},  -- Blood Guard's Dreadweave Gloves
	[17578]={s=12655},  -- Field Marshal's Coronal
	[17579]={s=16936},  -- Marshal's Dreadweave Leggings
	[17580]={s=12747},  -- Field Marshal's Dreadweave Shoulders
	[17581]={s=17059},  -- Field Marshal's Dreadweave Robe
	[17583]={s=12887},  -- Marshal's Dreadweave Boots
	[17584]={s=8847},  -- Marshal's Dreadweave Gloves
	[17586]={s=12093},  -- General's Dreadweave Boots
	[17588]={s=8124},  -- General's Dreadweave Gloves
	[17590]={s=12280},  -- Warlord's Dreadweave Mantle
	[17591]={s=12326},  -- Warlord's Dreadweave Hood
	[17592]={s=16497},  -- Warlord's Dreadweave Robe
	[17593]={s=16560},  -- General's Dreadweave Pants
	[17594]={s=8481},  -- Knight-Lieutenant's Satin Boots
	[17596]={s=5696},  -- Knight-Lieutenant's Satin Gloves
	[17598]={s=8607},  -- Lieutenant Commander's Diadem
	[17599]={s=11518},  -- Knight-Captain's Satin Leggings
	[17600]={s=11866},  -- Knight-Captain's Satin Robes
	[17601]={s=8931},  -- Lieutenant Commander's Satin Amice
	[17602]={s=13175},  -- Field Marshal's Headdress
	[17603]={s=17630},  -- Field Marshal's Satin Pants
	[17604]={s=13269},  -- Field Marshal's Satin Mantle
	[17605]={s=17755},  -- Field Marshal's Satin Vestments
	[17607]={s=12138},  -- Marshal's Satin Sandals
	[17608]={s=8123},  -- Marshal's Satin Gloves
	[17610]={s=8352},  -- Champion's Satin Cowl
	[17611]={s=11179},  -- Legionnaire's Satin Trousers
	[17612]={s=11221},  -- Legionnaire's Satin Vestments
	[17613]={s=8447},  -- Champion's Satin Shoulderpads
	[17616]={s=8772},  -- Blood Guard's Satin Boots
	[17617]={s=5868},  -- Blood Guard's Satin Gloves
	[17618]={s=12987},  -- General's Satin Boots
	[17620]={s=8721},  -- General's Satin Gloves
	[17622]={s=13174},  -- Warlord's Satin Mantle
	[17623]={s=13221},  -- Warlord's Satin Cowl
	[17624]={s=17691},  -- Warlord's Satin Robes
	[17625]={s=17752},  -- General's Satin Leggings
	[17662]={s=0},  -- Stolen Treats
	[17682]={s=8750},  -- Book: Gift of the Wild
	[17683]={s=14750},  -- Book: Gift of the Wild II
	[17684]={s=0},  -- Theradric Crystal Carving
	[17685]={s=0},  -- Smokywood Pastures Sampler
	[17686]={s=9937},  -- Master Hunter's Bow
	[17687]={s=9937},  -- Master Hunter's Rifle
	[17688]={s=3155},  -- Jungle Boots
	[17692]={s=881},  -- Horn Ring
	[17693]={s=0},  -- Coated Cerulean Vial
	[17694]={s=881},  -- Band of the Fist
	[17695]={s=930},  -- Chestnut Mantle
	[17696]={s=0},  -- Filled Cerulean Vial
	[17702]={s=0},  -- Celebrian Rod
	[17703]={s=0},  -- Celebrian Diamond
	[17704]={s=9178},  -- Edge of Winter
	[17705]={s=32854},  -- Thrash Blade
	[17706]={s=950},  -- Plans: Edge of Winter
	[17707]={s=11631},  -- Gemshard Heart
	[17708]={s=35},  -- Elixir of Frost Power
	[17709]={s=500},  -- Recipe: Elixir of Frost Power
	[17710]={s=35483},  -- Charstone Dirk
	[17711]={s=14244},  -- Elemental Rockridge Leggings
	[17712]={s=0},  -- Winter Veil Disguise Kit
	[17713]={s=14641},  -- Blackstone Ring
	[17714]={s=10225},  -- Bracers of the Stone Princess
	[17715]={s=10225},  -- Eye of Theradras
	[17716]={s=7500},  -- SnowMaster 9000
	[17717]={s=26425},  -- Megashot Rifle
	[17718]={s=22630},  -- Gizlock's Hypertech Buckler
	[17719]={s=32106},  -- Inventor's Focal Sword
	[17720]={s=600},  -- Schematic: Snowmaster 9000
	[17721]={s=2268},  -- Gloves of the Greatfather
	[17722]={s=700},  -- Pattern: Gloves of the Greatfather
	[17723]={s=750},  -- Green Holiday Shirt
	[17724]={s=375},  -- Pattern: Green Holiday Shirt
	[17725]={s=750},  -- Formula: Enchant Weapon - Winter Might
	[17726]={s=0},  -- Smokywood Pastures Special Gift
	[17727]={s=0},  -- Smokywood Pastures Gift Pack
	[17728]={s=12458},  -- Albino Crocscale Boots
	[17730]={s=42951},  -- Gatorbite Axe
	[17732]={s=10383},  -- Rotgrip Mantle
	[17733]={s=34735},  -- Fist of Stone
	[17734]={s=10457},  -- Helm of the Mountain
	[17735]={s=0},  -- The Feast of Winter Veil
	[17736]={s=9646},  -- Rockgrip Gauntlets
	[17737]={s=10163},  -- Cloud Stone
	[17738]={s=33351},  -- Claw of Celebras
	[17739]={s=9100},  -- Grovekeeper's Drape
	[17740]={s=11401},  -- Soothsayer's Headdress
	[17741]={s=11447},  -- Nature's Embrace
	[17742]={s=14450},  -- Fungus Shroud Armor
	[17743]={s=40747},  -- Resurgence Rod
	[17744]={s=9031},  -- Heart of Noxxion
	[17745]={s=22519},  -- Noxious Shooter
	[17746]={s=5723},  -- Noxxion's Shackles
	[17747]={s=500},  -- Razorlash Root
	[17748]={s=9107},  -- Vinerot Sandals
	[17749]={s=11425},  -- Phytoskin Spaulders
	[17750]={s=4769},  -- Chloromesh Girdle
	[17751]={s=12787},  -- Brusslehide Leggings
	[17752]={s=28785},  -- Satyr's Lash
	[17753]={s=26046},  -- Verdant Keeper's Aim
	[17754]={s=17394},  -- Infernal Trickster Leggings
	[17755]={s=5818},  -- Satyrmane Sash
	[17756]={s=0},  -- Shadowshard Fragment
	[17757]={s=0},  -- Amulet of Spirits
	[17758]={s=0},  -- Amulet of Union
	[17759]={s=10307},  -- Mark of Resolution
	[17760]={s=0},  -- Seed of Life
	[17761]={s=0},  -- Gem of the First Kahn
	[17762]={s=0},  -- Gem of the Second Kahn
	[17763]={s=0},  -- Gem of the Third Kahn
	[17764]={s=0},  -- Gem of the Fourth Kahn
	[17765]={s=0},  -- Gem of the Fifth Kahn
	[17766]={s=44863},  -- Princess Theradras' Scepter
	[17767]={s=13610},  -- Bloomsprout Headpiece
	[17768]={s=7891},  -- Woodseed Hoop
	[17770]={s=3851},  -- Branchclaw Gauntlets
	[17772]={s=7132},  -- Zealous Shadowshard Pendant
	[17773]={s=7132},  -- Prodigious Shadowshard Pendant
	[17774]={s=6133},  -- Mark of the Chosen
	[17775]={s=7841},  -- Acumen Robes
	[17776]={s=7377},  -- Sprightring Helm
	[17777]={s=10815},  -- Relentless Chain
	[17778]={s=4506},  -- Sagebrush Girdle
	[17779]={s=5547},  -- Hulkstone Pauldrons
	[17780]={s=46796},  -- Blade of Eternal Darkness
	[17781]={s=0},  -- The Pariah's Instructions
	[17922]={s=115},  -- Lionfur Armor
	[17943]={s=32156},  -- Fist of Stone
	[17963]={s=213},  -- Green Sack of Gems
	[17964]={s=5512},  -- Gray Sack of Gems
	[17965]={s=213},  -- Yellow Sack of Gems
	[17966]={s=8750},  -- Onyxia Hide Backpack
	[17982]={s=23961},  -- Ragnaros Core
	[18022]={s=10709},  -- Royal Seal of Alexis
	[18042]={s=10},  -- Thorium Headed Arrow
	[18043]={s=12912},  -- Coal Miner Boots
	[18044]={s=33830},  -- Hurley's Tankard
	[18045]={s=300},  -- Tender Wolf Steak
	[18046]={s=3000},  -- Recipe: Tender Wolf Steak
	[18047]={s=24428},  -- Flame Walkers
	[18048]={s=43589},  -- Mastersmith's Hammer
	[18082]={s=28161},  -- Zum'rah's Vexing Cane
	[18083]={s=4522},  -- Jumanza Grips
	[18102]={s=17158},  -- Dragonrider Boots
	[18103]={s=15252},  -- Band of Rumination
	[18104]={s=17284},  -- Feralsurge Girdle
	[18151]={s=0},  -- Filled Amethyst Phial
	[18152]={s=0},  -- Amethyst Phial
	[18154]={s=0},  -- Blizzard Stationery
	[18160]={s=50},  -- Recipe: Thistle Tea
	[18168]={s=56416},  -- Force Reactive Disk
	[18169]={s=25000},  -- Flame Mantle of the Dawn
	[18170]={s=25000},  -- Frost Mantle of the Dawn
	[18171]={s=25000},  -- Arcane Mantle of the Dawn
	[18172]={s=25000},  -- Nature Mantle of the Dawn
	[18173]={s=25000},  -- Shadow Mantle of the Dawn
	[18182]={s=100000},  -- Chromatic Mantle of the Dawn
	[18202]={s=90576},  -- Eskhandar's Left Claw
	[18203]={s=90905},  -- Eskhandar's Right Claw
	[18204]={s=27370},  -- Eskhandar's Pelt
	[18205]={s=33287},  -- Eskhandar's Collar
	[18208]={s=29147},  -- Drape of Benediction
	[18222]={s=3070},  -- Thorny Vine
	[18223]={s=6142},  -- Serrated Petal
	[18224]={s=1728},  -- Lasher Root
	[18232]={s=10000},  -- Field Repair Bot 74A
	[18236]={s=2716},  -- Gordok Chew Toy
	[18237]={s=1622},  -- Mastiff Jawbone
	[18238]={s=3321},  -- Shadowskin Gloves
	[18239]={s=875},  -- Pattern: Shadowskin Gloves
	[18240]={s=0},  -- Ogre Tannin
	[18241]={s=0},  -- Black War Steed Bridle
	[18242]={s=0},  -- Reins of the Black War Tiger
	[18243]={s=0},  -- Black Battlestrider
	[18244]={s=0},  -- Black War Ram
	[18245]={s=0},  -- Horn of the Black War Wolf
	[18246]={s=0},  -- Whistle of the Black War Raptor
	[18247]={s=0},  -- Black War Kodo
	[18248]={s=0},  -- Red Skeletal Warhorse
	[18249]={s=0},  -- Crescent Key
	[18250]={s=0},  -- Gordok Shackle Key
	[18251]={s=5000},  -- Core Armor Kit
	[18253]={s=15},  -- Major Rejuvenation Potion
	[18254]={s=18},  -- Runn Tum Tuber Surprise
	[18255]={s=15},  -- Runn Tum Tuber
	[18256]={s=1500},  -- Imbued Vial
	[18257]={s=50000},  -- Recipe: Major Rejuvination Potion
	[18258]={s=0},  -- Gordok Ogre Suit
	[18261]={s=0},  -- Book of Incantations
	[18262]={s=1250},  -- Elemental Sharpening Stone
	[18263]={s=16911},  -- Flarecore Wraps
	[18266]={s=0},  -- Gordok Courtyard Key
	[18267]={s=5000},  -- Recipe: Runn Tum Tuber Surprise
	[18268]={s=0},  -- Gordok Inner Door Key
	[18269]={s=375},  -- Gordok Green Grog
	[18282]={s=66347},  -- Core Marksman Rifle
	[18284]={s=375},  -- Kreeg's Stout Beatdown
	[18285]={s=4558},  -- Crystallized Mana Shard
	[18286]={s=2953},  -- Condensed Mana Fragment
	[18287]={s=50},  -- Evermurky
	[18288]={s=250},  -- Molasses Firewater
	[18289]={s=9701},  -- Barbed Thorn Necklace
	[18291]={s=30000},  -- Schematic: Force Reactive Disk
	[18294]={s=250},  -- Elixir of Greater Water Breathing
	[18295]={s=11582},  -- Phasing Boots
	[18296]={s=11489},  -- Marksman Bands
	[18297]={s=0},  -- Thornling Seed
	[18298]={s=20685},  -- Unbridled Leggings
	[18299]={s=0},  -- Hydrospawn Essence
	[18301]={s=29363},  -- Lethtendris's Wand
	[18302]={s=7530},  -- Band of Vigor
	[18305]={s=14375},  -- Breakwater Legguards
	[18306]={s=7215},  -- Gloves of Shadowy Mist
	[18307]={s=11163},  -- Riptide Shoes
	[18308]={s=13447},  -- Clever Hat
	[18309]={s=11296},  -- Gloves of Restoration
	[18310]={s=47406},  -- Fiendish Machete
	[18311]={s=56644},  -- Quel'dorai Channeling Rod
	[18312]={s=18073},  -- Energized Chestplate
	[18313]={s=13694},  -- Helm of Awareness
	[18314]={s=12100},  -- Ring of Demonic Guile
	[18315]={s=12100},  -- Ring of Demonic Potency
	[18317]={s=12503},  -- Tempest Talisman
	[18318]={s=22057},  -- Merciful Greaves
	[18319]={s=20989},  -- Fervent Helm
	[18321]={s=49320},  -- Energetic Rod
	[18322]={s=16137},  -- Waterspout Boots
	[18323]={s=32988},  -- Satyr's Bow
	[18324]={s=55189},  -- Waveslicer
	[18325]={s=16137},  -- Felhide Cap
	[18326]={s=9036},  -- Razor Gauntlets
	[18327]={s=9376},  -- Whipvine Cord
	[18328]={s=14116},  -- Shadewood Cloak
	[18329]={s=0},  -- Arcanum of Rapidity
	[18330]={s=0},  -- Arcanum of Focus
	[18331]={s=0},  -- Arcanum of Protection
	[18332]={s=0},  -- Libram of Rapidity
	[18333]={s=0},  -- Libram of Focus
	[18334]={s=0},  -- Libram of Protection
	[18335]={s=0},  -- Pristine Black Diamond
	[18336]={s=0},  -- Gauntlet of Gordok Might
	[18337]={s=8103},  -- Orphic Bracers
	[18338]={s=36595},  -- Wand of Arcane Potency
	[18339]={s=11370},  -- Eidolon Cloak
	[18340]={s=28853},  -- Eidolon Talisman
	[18343]={s=14615},  -- Petrified Band
	[18344]={s=11296},  -- Stonebark Gauntlets
	[18345]={s=14727},  -- Murmuring Ring
	[18346]={s=16345},  -- Threadbare Trousers
	[18347]={s=43067},  -- Well Balanced Axe
	[18348]={s=112651},  -- Quel'Serrar
	[18349]={s=12454},  -- Gauntlets of Accuracy
	[18350]={s=13063},  -- Amplifying Cloak
	[18351]={s=8740},  -- Magically Sealed Bracers
	[18352]={s=28072},  -- Petrified Bark Shield
	[18353]={s=55030},  -- Stoneflower Staff
	[18354]={s=17466},  -- Pimgib's Collar
	[18356]={s=0},  -- Garona: A Study on Stealth and Treachery
	[18357]={s=0},  -- Codex of Defense
	[18358]={s=0},  -- The Arcanist's Cookbook
	[18359]={s=0},  -- The Light and How to Swing It
	[18360]={s=0},  -- Harnessing Shadows
	[18361]={s=0},  -- The Greatest Race of Hunters
	[18362]={s=0},  -- Holy Bologna: What the Light Won't Tell You
	[18363]={s=0},  -- Frost Shock and You
	[18364]={s=0},  -- The Emerald Dream: Fact or Carefully Planned Out Farce Perpetrated By My Brother
	[18365]={s=0},  -- A Thoroughly Read Copy of "Nat Pagle's Extreme' Anglin."
	[18366]={s=9805},  -- Gordok's Handguards
	[18367]={s=14762},  -- Gordok's Gauntlets
	[18368]={s=12348},  -- Gordok's Gloves
	[18369]={s=9915},  -- Gordok's Handwraps
	[18370]={s=21612},  -- Vigilance Charm
	[18371]={s=20737},  -- Mindtap Talisman
	[18372]={s=56716},  -- Blade of the New Moon
	[18373]={s=28459},  -- Chestplate of Tranquility
	[18374]={s=21418},  -- Flamescarred Shoulders
	[18375]={s=14329},  -- Bracers of the Eclipse
	[18376]={s=52306},  -- Timeworn Mace
	[18377]={s=13076},  -- Quickdraw Gloves
	[18378]={s=31384},  -- Silvermoon Leggings
	[18379]={s=23791},  -- Odious Greaves
	[18380]={s=21135},  -- Eldritch Reinforced Legplates
	[18381]={s=21635},  -- Evil Eye Pendant
	[18382]={s=15971},  -- Fluctuating Cloak
	[18383]={s=10179},  -- Force Imbued Gauntlets
	[18384]={s=16093},  -- Bile-etched Spaulders
	[18385]={s=21536},  -- Robe of Everlasting Night
	[18386]={s=20588},  -- Padre's Trousers
	[18387]={s=9488},  -- Brightspark Gloves
	[18388]={s=41928},  -- Stoneshatter
	[18389]={s=16830},  -- Cloak of the UltimateUI
	[18390]={s=26811},  -- Tanglemoss Leggings
	[18391]={s=13076},  -- Eyestalk Cord
	[18392]={s=56710},  -- Distracting Dagger
	[18393]={s=14944},  -- Warpwood Binding
	[18394]={s=17133},  -- Demon Howl Wristguards
	[18395]={s=36645},  -- Emerald Flame Ring
	[18396]={s=57516},  -- Mind Carver
	[18397]={s=22464},  -- Elder Magus Pendant
	[18398]={s=27103},  -- Tidal Loop
	[18399]={s=27103},  -- Ocean's Breeze
	[18400]={s=14853},  -- Ring of Living Stone
	[18401]={s=0},  -- Foror's Compendium of Dragon Slaying
	[18402]={s=18662},  -- Glowing Crystal Ring
	[18403]={s=49060},  -- Dragonslayer's Signet
	[18404]={s=6714},  -- Onyxia Tooth Pendant
	[18405]={s=14744},  -- Belt of the Archmage
	[18406]={s=46030},  -- Onyxia Blood Talisman
	[18407]={s=11139},  -- Felcloth Gloves
	[18408]={s=11178},  -- Inferno Gloves
	[18409]={s=11219},  -- Mooncloth Gloves
	[18410]={s=45516},  -- Sprinter's Sword
	[18411]={s=12686},  -- Spry Boots
	[18412]={s=0},  -- Core Fragment
	[18413]={s=17070},  -- Cloak of Warding
	[18414]={s=30000},  -- Pattern: Belt of the Archmage
	[18415]={s=10000},  -- Pattern: Felcloth Gloves
	[18416]={s=10000},  -- Pattern: Inferno Gloves
	[18417]={s=10000},  -- Pattern: Mooncloth Gloves
	[18418]={s=10000},  -- Pattern: Cloak of Warding
	[18420]={s=71236},  -- Bonecrusher
	[18421]={s=25741},  -- Backwood Helm
	[18422]={s=0},  -- Head of Onyxia
	[18423]={s=0},  -- Head of Onyxia
	[18424]={s=20595},  -- Sedge Boots
	[18425]={s=5537},  -- Kreeg's Mug
	[18426]={s=0},  -- Lethtendris's Web
	[18427]={s=1322},  -- Sergeant's Cloak
	[18428]={s=7500},  -- Senior Sergeant's Insignia
	[18429]={s=5889},  -- First Sergeant's Plate Bracers
	[18430]={s=2878},  -- First Sergeant's Plate Bracers
	[18432]={s=4348},  -- First Sergeant's Mail Wristguards
	[18434]={s=7493},  -- First Sergeant's Dragonhide Armguards
	[18435]={s=3662},  -- First Sergeant's Leather Armguards
	[18436]={s=3417},  -- First Sergeant's Dragonhide Armguards
	[18437]={s=2744},  -- First Sergeant's Silk Cuffs
	[18440]={s=1288},  -- Sergeant's Cape
	[18441]={s=4178},  -- Sergeant's Cape
	[18442]={s=5000},  -- Master Sergeant's Insignia
	[18443]={s=10000},  -- Master Sergeant's Insignia
	[18444]={s=7500},  -- Master Sergeant's Insignia
	[18445]={s=5804},  -- Sergeant Major's Plate Wristguards
	[18447]={s=2847},  -- Sergeant Major's Plate Wristguards
	[18448]={s=8801},  -- Sergeant Major's Chain Armguards
	[18449]={s=4301},  -- Sergeant Major's Chain Armguards
	[18450]={s=15814},  -- Robe of Combustion
	[18451]={s=9884},  -- Hyena Hide Belt
	[18452]={s=6910},  -- Sergeant Major's Dragonhide Armsplints
	[18453]={s=3343},  -- Sergeant Major's Dragonhide Armsplints
	[18454]={s=1154},  -- Sergeant Major's Leather Armsplints
	[18455]={s=3343},  -- Sergeant Major's Leather Armsplints
	[18456]={s=5613},  -- Sergeant Major's Silk Cuffs
	[18457]={s=2674},  -- Sergeant Major's Silk Cuffs
	[18458]={s=12212},  -- Modest Armguards
	[18459]={s=7907},  -- Gallant's Wristguards
	[18460]={s=30762},  -- Unsophisticated Hand Cannon
	[18461]={s=8577},  -- Sergeant's Cloak
	[18462]={s=41319},  -- Jagged Bone Fist
	[18463]={s=39536},  -- Ogre Pocket Knife
	[18464]={s=29135},  -- Gordok Nose Ring
	[18465]={s=0},  -- Royal Seal of Eldre'Thalas
	[18466]={s=0},  -- Royal Seal of Eldre'Thalas
	[18467]={s=0},  -- Royal Seal of Eldre'Thalas
	[18468]={s=0},  -- Royal Seal of Eldre'Thalas
	[18469]={s=0},  -- Royal Seal of Eldre'Thalas
	[18470]={s=0},  -- Royal Seal of Eldre'Thalas
	[18471]={s=0},  -- Royal Seal of Eldre'Thalas
	[18472]={s=0},  -- Royal Seal of Eldre'Thalas
	[18473]={s=0},  -- Royal Seal of Eldre'Thalas
	[18475]={s=7907},  -- Oddly Magical Belt
	[18476]={s=15149},  -- Mud Stained Boots
	[18477]={s=19768},  -- Shaggy Leggings
	[18478]={s=19768},  -- Hyena Hide Jerkin
	[18479]={s=17791},  -- Carrion Scorpid Helm
	[18480]={s=11860},  -- Scarab Plate Helm
	[18481]={s=51451},  -- Skullcracking Mace
	[18482]={s=29652},  -- Ogre Toothpick Shooter
	[18483]={s=37362},  -- Mana Channeling Wand
	[18484]={s=53822},  -- Cho'Rush's Blade
	[18485]={s=34569},  -- Observer's Shield
	[18486]={s=21683},  -- Mooncloth Robe
	[18487]={s=10000},  -- Pattern: Mooncloth Robe
	[18488]={s=0},  -- Heated Ancient Blade
	[18489]={s=0},  -- Unfired Ancient Blade
	[18490]={s=18655},  -- Insightful Hood
	[18491]={s=40695},  -- Lorespinner
	[18492]={s=0},  -- Treated Ancient Blade
	[18493]={s=14233},  -- Bulky Iron Spaulders
	[18494]={s=21444},  -- Denwatcher's Shoulders
	[18495]={s=16770},  -- Redoubt Cloak
	[18496]={s=14233},  -- Heliotrope Cloak
	[18497]={s=9488},  -- Sublime Wristguards
	[18498]={s=47443},  -- Hedgecutter
	[18499]={s=34589},  -- Barrier Shield
	[18500]={s=31340},  -- Tarnished Elven Ring
	[18501]={s=0},  -- Felvine Shard
	[18502]={s=70127},  -- Monstrous Glaive
	[18503]={s=22521},  -- Kromcrush's Chestplate
	[18504]={s=14126},  -- Girdle of Insight
	[18505]={s=13076},  -- Mugger's Belt
	[18506]={s=21340},  -- Mongoose Boots
	[18507]={s=15692},  -- Boots of the Full Moon
	[18508]={s=17194},  -- Swift Flight Bracers
	[18509]={s=23006},  -- Chromatic Cloak
	[18510]={s=20889},  -- Hide of the Wild
	[18511]={s=20971},  -- Shifting Cloak
	[18512]={s=4000},  -- Larval Acid
	[18513]={s=0},  -- A Dull and Flat Elven Blade
	[18514]={s=15000},  -- Pattern: Girdle of Insight
	[18515]={s=15000},  -- Pattern: Mongoose Boots
	[18516]={s=15000},  -- Pattern: Swift Flight Bracers
	[18517]={s=40000},  -- Pattern: Chromatic Cloak
	[18518]={s=40000},  -- Pattern: Hide of the Wild
	[18519]={s=40000},  -- Pattern: Shifting Cloak
	[18520]={s=68652},  -- Barbarous Blade
	[18521]={s=17606},  -- Grimy Metal Boots
	[18522]={s=36253},  -- Band of the Ogre King
	[18523]={s=34810},  -- Brightly Glowing Stone
	[18524]={s=35596},  -- Leggings of Destruction
	[18525]={s=13730},  -- Bracers of Prosperity
	[18526]={s=17924},  -- Crown of the Ogre King
	[18527]={s=17988},  -- Harmonious Gauntlets
	[18528]={s=20465},  -- Cyclone Spaulders
	[18529]={s=9963},  -- Elemental Plate Girdle
	[18530]={s=31331},  -- Ogre Forged Hauberk
	[18531]={s=65383},  -- Unyielding Maul
	[18532]={s=21629},  -- Mindsurge Robe
	[18533]={s=10984},  -- Gordok Bracers of Power
	[18534]={s=71503},  -- Rod of the Ogre Magi
	[18535]={s=30231},  -- Milli's Shield
	[18536]={s=38664},  -- Milli's Lexicon
	[18537]={s=66135},  -- Counterattack Lodestone
	[18538]={s=96748},  -- Treant's Bane
	[18539]={s=0},  -- Reliquary of Purity
	[18540]={s=0},  -- Sealed Reliquary of Purity
	[18541]={s=33028},  -- Puissant Cape
	[18542]={s=125278},  -- Typhoon
	[18543]={s=63728},  -- Ring of Entropy
	[18544]={s=29212},  -- Doomhide Gauntlets
	[18545]={s=42546},  -- Leggings of Arcane Supremacy
	[18546]={s=48035},  -- Infernal Headcage
	[18547]={s=23619},  -- Unmelting Ice Girdle
	[18564]={s=0},  -- Bindings of the Wind Seeker
	[18565]={s=14853},  -- Band of Allegiance
	[18566]={s=14853},  -- Lonetree's Circle
	[18585]={s=14853},  -- Band of Allegiance
	[18586]={s=14853},  -- Lonetree's Circle
	[18587]={s=2000},  -- Goblin Jumper Cables XL
	[18588]={s=200},  -- Ez-Thro Dynamite II
	[18590]={s=0},  -- Raging Beast's Blood
	[18591]={s=0},  -- Case of Blood
	[18594]={s=3000},  -- Powerful Seaforium Charge
	[18597]={s=0},  -- Orcish Orphan Whistle
	[18598]={s=0},  -- Human Orphan Whistle
	[18600]={s=12000},  -- Tome of Arcane Brilliance
	[18601]={s=0},  -- Glowing Crystal Prison
	[18602]={s=0},  -- Tome of Sacrifice
	[18603]={s=0},  -- Satyr Blood
	[18604]={s=0},  -- Tears of the Hederine
	[18605]={s=0},  -- Imprisoned Doomguard
	[18606]={s=12500},  -- Alliance Battle Standard
	[18607]={s=12500},  -- Horde Battle Standard
	[18608]={s=0},  -- Benediction
	[18609]={s=0},  -- Anathema
	[18610]={s=36},  -- Keen Machete
	[18611]={s=27},  -- Gnarlpine Leggings
	[18612]={s=34},  -- Bloody Chain Boots
	[18622]={s=0},  -- Flawless Fel Essence (Jaedenar)
	[18623]={s=0},  -- Flawless Fel Essence (Dark Portal)
	[18624]={s=0},  -- Flawless Fel Essence (Azshara)
	[18625]={s=0},  -- Kroshius' Infernal Core
	[18626]={s=0},  -- Fel Fire
	[18629]={s=0},  -- Black Lodestone
	[18631]={s=3000},  -- Truesilver Transformer
	[18632]={s=50},  -- Moonbrook Riot Taffy
	[18633]={s=6},  -- Styleen's Sour Suckerpop
	[18634]={s=12500},  -- Gyrofreeze Ice Reflector
	[18635]={s=100},  -- Bellara's Nutterbar
	[18636]={s=100},  -- Ruined Jumper Cables XL
	[18637]={s=600},  -- Major Recombobulator
	[18638]={s=12500},  -- Hyper-Radiant Flame Reflector
	[18639]={s=12500},  -- Ultra-Flash Shadow Reflector
	[18640]={s=0},  -- Happy Fun Rock
	[18641]={s=500},  -- Dense Dynamite
	[18642]={s=0},  -- Jaina's Autograph
	[18643]={s=0},  -- Cairne's Hoofprint
	[18645]={s=1500},  -- Alarm-O-Bot
	[18646]={s=0},  -- The Eye of Divinity
	[18647]={s=450},  -- Schematic: Red Firework
	[18648]={s=450},  -- Schematic: Green Firework
	[18649]={s=450},  -- Schematic: Blue Firework
	[18650]={s=1250},  -- Schematic: EZ-Thro Dynamite II
	[18651]={s=3000},  -- Schematic: Truesilver Transformer
	[18652]={s=3000},  -- Schematic: Gyrofreeze Ice Reflector
	[18653]={s=4000},  -- Schematic: Goblin Jumper Cables XL
	[18654]={s=4000},  -- Schematic: Gnomish Alarm-O-Bot
	[18655]={s=4000},  -- Schematic: Major Recombobulator
	[18656]={s=4000},  -- Schematic: Powerful Seaforium Charge
	[18657]={s=5000},  -- Schematic: Hyper-Radiant Flame Reflector
	[18658]={s=6000},  -- Schematic: Ultra-Flash Shadow Reflector
	[18659]={s=0},  -- Splinter of Nordrassil
	[18660]={s=7500},  -- World Enlarger
	[18661]={s=3000},  -- Schematic: World Enlarger
	[18662]={s=5},  -- Heavy Leather Ball
	[18663]={s=0},  -- J'eevee's Jar
	[18664]={s=25},  -- A Treatise on Military Ranks
	[18665]={s=0},  -- The Eye of Shadow
	[18670]={s=0},  -- Xorothian Glyphs
	[18671]={s=45184},  -- Baron Charr's Sceptre
	[18672]={s=17855},  -- Elemental Ember
	[18673]={s=28918},  -- Avalanchion's Stony Hide
	[18674]={s=22003},  -- Hardened Stone Band
	[18675]={s=25},  -- Military Ranks of the Horde & Alliance
	[18676]={s=16080},  -- Sash of the Windreaver
	[18677]={s=12487},  -- Zephyr Cloak
	[18678]={s=26635},  -- Tempestria's Frozen Necklace
	[18679]={s=25136},  -- Frigid Ring
	[18680]={s=37894},  -- Ancient Bone Bow
	[18681]={s=15215},  -- Burial Shawl
	[18682]={s=25456},  -- Ghoul Skin Leggings
	[18683]={s=51100},  -- Hammer of the Vesper
	[18684]={s=36141},  -- Dimly Opalescent Ring
	[18686]={s=24527},  -- Bone Golem Shoulders
	[18687]={s=0},  -- Xorothian Stardust
	[18688]={s=0},  -- Imp in a Jar
	[18689]={s=16460},  -- Phantasmal Cloak
	[18690]={s=22026},  -- Wraithplate Leggings
	[18691]={s=31400},  -- Dark Advisor's Pendant
	[18692]={s=14375},  -- Death Knight Sabatons
	[18693]={s=11425},  -- Shivery Handwraps
	[18694]={s=25910},  -- Shadowy Mail Greaves
	[18695]={s=34450},  -- Spellbound Tome
	[18696]={s=33476},  -- Intricately Runed Shield
	[18697]={s=10867},  -- Coldstone Slippers
	[18698]={s=14362},  -- Tattered Leather Hood
	[18699]={s=15223},  -- Icy Tomb Spaulders
	[18700]={s=10910},  -- Malefic Bracers
	[18701]={s=36410},  -- Innervating Band
	[18702]={s=9488},  -- Belt of the Ordained
	[18703]={s=0},  -- Ancient Petrified Leaf
	[18704]={s=0},  -- Mature Blue Dragon Sinew
	[18705]={s=0},  -- Mature Black Dragon Sinew
	[18706]={s=10031},  -- Arena Master
	[18707]={s=0},  -- Ancient Rune Etched Stave
	[18708]={s=0},  -- Petrified Bark
	[18709]={s=5758},  -- Arena Wristguards
	[18710]={s=7224},  -- Arena Bracers
	[18711]={s=8700},  -- Arena Bands
	[18712]={s=5821},  -- Arena Vambraces
	[18713]={s=0},  -- Rhok'delar, Longbow of the Ancient Keepers
	[18714]={s=0},  -- Ancient Sinew Wrapped Lamina
	[18715]={s=180778},  -- Lok'delar, Stave of the Ancient Keepers
	[18716]={s=18655},  -- Ash Covered Boots
	[18717]={s=68818},  -- Hammer of the Grand Crusader
	[18718]={s=16580},  -- Grand Crusader's Helm
	[18719]={s=0},  -- The Traitor's Heart
	[18720]={s=16706},  -- Shroud of the Nathrezim
	[18721]={s=14944},  -- Barrage Girdle
	[18722]={s=10688},  -- Death Grips
	[18723]={s=41953},  -- Animated Chain Necklace
	[18724]={s=0},  -- Enchanted Black Dragon Sinew
	[18725]={s=59927},  -- Peacemaker
	[18726]={s=11296},  -- Magistrate's Cuffs
	[18727]={s=14487},  -- Crimson Felt Hat
	[18728]={s=32466},  -- Anastari Heirloom
	[18729]={s=38302},  -- Screeching Bow
	[18730]={s=10250},  -- Shadowy Laced Handwraps
	[18731]={s=500},  -- Pattern: Heavy Leather Ball
	[18734]={s=17194},  -- Pale Moon Cloak
	[18735]={s=17253},  -- Maleki's Footwraps
	[18736]={s=26112},  -- Plaguehound Leggings
	[18737]={s=52427},  -- Bone Slicing Hatchet
	[18738]={s=37593},  -- Carapace Spine Crossbow
	[18739]={s=20124},  -- Chitinous Plate Legguards
	[18740]={s=10101},  -- Thuzadin Sash
	[18741]={s=9963},  -- Morlune's Bracer
	[18742]={s=21444},  -- Stratholme Militia Shoulderguard
	[18743]={s=13555},  -- Gracious Cape
	[18744]={s=11371},  -- Plaguebat Fur Gloves
	[18745]={s=16238},  -- Sacred Cloth Leggings
	[18746]={s=0},  -- Divination Scryer
	[18749]={s=0},  -- Charger's Lost Soul
	[18752]={s=0},  -- Exorcism Censer
	[18753]={s=0},  -- Arcanite Barding
	[18754]={s=10461},  -- Fel Hardened Bracers
	[18755]={s=43129},  -- Xorothian Firestick
	[18756]={s=33420},  -- Dreadguard's Protector
	[18757]={s=16162},  -- Diabolic Mantle
	[18758]={s=54072},  -- Specter's Blade
	[18759]={s=67844},  -- Malicious Axe
	[18760]={s=30866},  -- Necromantic Band
	[18761]={s=39230},  -- Oblivion's Touch
	[18762]={s=27631},  -- Shard of the Green Flame
	[18766]={s=0},  -- Reins of the Swift Frostsaber
	[18767]={s=0},  -- Reins of the Swift Mistsaber
	[18769]={s=0},  -- Advanced Armorsmithing I - Enchanted Thorium Platemail
	[18770]={s=0},  -- Advanced Armorsmithing II - Enchanted Thorium Platemail
	[18771]={s=0},  -- Advanced Armorsmithing III - Enchanted Thorium Platemail
	[18772]={s=0},  -- Swift Green Mechanostrider
	[18773]={s=0},  -- Swift White Mechanostrider
	[18774]={s=0},  -- Swift Yellow Mechanostrider
	[18775]={s=0},  -- Manna-Enriched Horse Feed
	[18776]={s=0},  -- Swift Palomino
	[18777]={s=0},  -- Swift Brown Steed
	[18778]={s=0},  -- Swift White Steed
	[18779]={s=0},  -- Bottom Half of Advanced Armorsmithing: Volume I
	[18780]={s=0},  -- Top Half of Advanced Armorsmithing: Volume I
	[18781]={s=0},  -- Bottom Half of Advanced Armorsmithing: Volume II
	[18782]={s=0},  -- Top Half of Advanced Armorsmithing: Volume II
	[18783]={s=0},  -- Bottom Half of Advanced Armorsmithing: Volume III
	[18784]={s=0},  -- Top Half of Advanced Armorsmithing: Volume III
	[18785]={s=0},  -- Swift White Ram
	[18786]={s=0},  -- Swift Brown Ram
	[18787]={s=0},  -- Swift Gray Ram
	[18788]={s=0},  -- Swift Blue Raptor
	[18789]={s=0},  -- Swift Green Raptor
	[18790]={s=0},  -- Swift Orange Raptor
	[18791]={s=0},  -- Purple Skeletal Warhorse
	[18792]={s=0},  -- Blessed Arcanite Barding
	[18793]={s=0},  -- Great White Kodo
	[18794]={s=0},  -- Great Brown Kodo
	[18795]={s=0},  -- Great Gray Kodo
	[18796]={s=0},  -- Horn of the Swift Brown Wolf
	[18797]={s=0},  -- Horn of the Swift Timber Wolf
	[18798]={s=0},  -- Horn of the Swift Gray Wolf
	[18799]={s=0},  -- Charger's Redeemed Soul
	[18802]={s=5000},  -- Shadowy Potion
	[18803]={s=135594},  -- Finkle's Lava Dredger
	[18804]={s=0},  -- Lord Grayson's Satchel
	[18805]={s=109275},  -- Core Hound Tooth
	[18806]={s=33761},  -- Core Forged Greaves
	[18807]={s=25796},  -- Helm of Latent Power
	[18808]={s=22665},  -- Gloves of the Hypnotic Flame
	[18809]={s=21611},  -- Sash of Whispered Secrets
	[18810]={s=40678},  -- Wild Growth Spaulders
	[18811]={s=32665},  -- Fireproof Cloak
	[18812]={s=32458},  -- Wristguards of True Flight
	[18813]={s=0},  -- Ring of Binding
	[18814]={s=0},  -- Choker of the Fire Lord
	[18815]={s=64095},  -- Essence of the Pure Flame
	[18817]={s=63975},  -- Crown of Destruction
	[18818]={s=0},  -- Mor'zul's Instructions
	[18819]={s=0},  -- Rohan's Exorcism Censer
	[18820]={s=0},  -- Talisman of Ephemeral Power
	[18821]={s=64030},  -- Quick Strike Ring
	[18822]={s=125768},  -- Obsidian Edged Blade
	[18823]={s=26506},  -- Aged Core Leather Gloves
	[18824]={s=33518},  -- Magma Tempered Boots
	[18825]={s=16868},  -- Grand Marshal's Aegis
	[18826]={s=16926},  -- High Warlord's Shield Wall
	[18827]={s=30725},  -- Grand Marshal's Handaxe
	[18828]={s=30834},  -- High Warlord's Cleaver
	[18829]={s=48903},  -- Deep Earth Spaulders
	[18830]={s=35132},  -- Grand Marshal's Sunderer
	[18831]={s=35268},  -- High Warlord's Battle Axe
	[18832]={s=104089},  -- Brutality Blade
	[18833]={s=21322},  -- Grand Marshal's Bullseye
	[18834]={s=3750},  -- Insignia of the Horde
	[18835]={s=21485},  -- High Warlord's Recurve
	[18836]={s=21566},  -- Grand Marshal's Repeater
	[18837]={s=21646},  -- High Warlord's Crossbow
	[18838]={s=29749},  -- Grand Marshal's Dirk
	[18839]={s=250},  -- Combat Healing Potion
	[18840]={s=29966},  -- High Warlord's Razor
	[18841]={s=275},  -- Combat Mana Potion
	[18842]={s=138646},  -- Staff of Dominance
	[18843]={s=30290},  -- Grand Marshal's Right Knuckles
	[18844]={s=30399},  -- High Warlord's Right Claw
	[18845]={s=3750},  -- Insignia of the Horde
	[18846]={s=3750},  -- Insignia of the Horde
	[18847]={s=30722},  -- Grand Marshal's Left Knuckles
	[18848]={s=30828},  -- High Warlord's Left Claw
	[18849]={s=3750},  -- Insignia of the Horde
	[18850]={s=3750},  -- Insignia of the Horde
	[18851]={s=3750},  -- Insignia of the Horde
	[18852]={s=3750},  -- Insignia of the Horde
	[18853]={s=3750},  -- Insignia of the Horde
	[18854]={s=3750},  -- Insignia of the Alliance
	[18855]={s=22067},  -- Grand Marshal's Hand Cannon
	[18856]={s=3750},  -- Insignia of the Alliance
	[18857]={s=3750},  -- Insignia of the Alliance
	[18858]={s=3750},  -- Insignia of the Alliance
	[18859]={s=3750},  -- Insignia of the Alliance
	[18860]={s=22470},  -- High Warlord's Street Sweeper
	[18861]={s=28493},  -- Flamewaker Legplates
	[18862]={s=3750},  -- Insignia of the Alliance
	[18863]={s=3750},  -- Insignia of the Alliance
	[18864]={s=3750},  -- Insignia of the Alliance
	[18865]={s=30501},  -- Grand Marshal's Punisher
	[18866]={s=30610},  -- High Warlord's Bludgeon
	[18867]={s=38395},  -- Grand Marshal's Battle Hammer
	[18868]={s=38531},  -- High Warlord's Pulverizer
	[18869]={s=34989},  -- Grand Marshal's Glaive
	[18870]={s=31384},  -- Helm of the Lifegiver
	[18871]={s=36231},  -- High Warlord's Pig Sticker
	[18872]={s=30394},  -- Manastorm Leggings
	[18873]={s=36503},  -- Grand Marshal's Stave
	[18874]={s=36639},  -- High Warlord's War Staff
	[18875]={s=38445},  -- Salamander Scale Pants
	[18876]={s=36907},  -- Grand Marshal's Claymore
	[18877]={s=37043},  -- High Warlord's Greatsword
	[18878]={s=85645},  -- Sorcerous Dagger
	[18879]={s=53364},  -- Heavy Dark Iron Ring
	[18880]={s=0},  -- Darkreaver's Head
	[18902]={s=0},  -- Reins of the Swift Stormsaber
	[18922]={s=0},  -- Simone's Head
	[18923]={s=0},  -- Klinfran's Head
	[18924]={s=0},  -- Solenor's Head
	[18925]={s=0},  -- Artorius's Head
};
end
