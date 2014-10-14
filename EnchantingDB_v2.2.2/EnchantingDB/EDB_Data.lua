--------------[[ VALUE DEFINITIONS ]]--------------

-- All definition
local ALL      = 1;

-- Items
local BOOTS    = 2;
local BRACER   = 3;
local CHEST    = 4;
local CLOAK    = 5;
local GLOVES   = 6;
local SHIELD   = 7;
local WEAPON   = 8;
local WEAPON2H = 9;
local OIL	   = 10;
local WAND	   = 11
local ROD	   = 12;
local IOTHER   = 13;

-- Bonuses
local AGI    = 2;
local INT    = 3;
local SPI    = 4;
local STA    = 5;
local STR    = 6;
local DMG    = 7;
local RES    = 8;
local STAT   = 9;
local PROC   = 10;
local ITEM	 = 11;
local BOTHER = 12;

-- Source
local TRAINER = 1;
local VENDOR  = 2;
local DROP    = 3;

-- Rods
local NONE = 0;
local RCR = 1;
local RSR = 2;
local RGR = 3;
local RTR = 4;
local RAR = 5;

-- Reagents
local TD = 10940;
local SD = 11083;
local VD = 11137;
local DD = 11176;
local ID = 16204;

local LME = 10938;
local GME = 10939;
local LAE = 10998;
local GAE = 11082;
local LYE = 11134;
local GYE = 11135;
local LNE = 11174;
local GNE = 11175;
local LEE = 16202;
local GEE = 16203;

local SGS = 10978;
local LGS = 11084;
local SWS = 11138;
local LWS = 11139;
local SRS = 11177;
local LRS = 11178;
local SBS = 14343;
local LBS = 14344;

local NC  = 20725;

local EV = 3371;
local LV = 3372;
local CV = 8925;
local IV = 18256;


----------------[[ RODS ]]----------------

EDB_Rod = {};

EDB_Rod[0] = "None";
EDB_Rod[1] = "|cffffffff|Hitem:6218:0:0:0|h[Runed Copper Rod]|h|r";
EDB_Rod[2] = "|cffffffff|Hitem:6339:0:0:0|h[Runed Silver Rod]|h|r";
EDB_Rod[3] = "|cffffffff|Hitem:11130:0:0:0|h[Runed Golden Rod]|h|r";
EDB_Rod[4] = "|cffffffff|Hitem:11145:0:0:0|h[Runed Truesilver Rod]|h|r";
EDB_Rod[5] = "|cffffffff|Hitem:16207:0:0:0|h[Runed Arcanite Rod]|h|r";
EDB_Rod[6] = "Black Forge";


--------------[[ REAGENTS ]]--------------

EDB_Reagent = {};
EDB_Reagent_Index = {};

-----[[ DUSTS ]]-----
EDB_Reagent_Index[1]  = 10940;	EDB_Reagent[10940] = "|cffffffff|Hitem:10940:0:0:0|h[Strange Dust]|h|r";
EDB_Reagent_Index[2]  = 11083;	EDB_Reagent[11083] = "|cffffffff|Hitem:11083:0:0:0|h[Soul Dust]|h|r";
EDB_Reagent_Index[3]  = 11137;	EDB_Reagent[11137] = "|cffffffff|Hitem:11137:0:0:0|h[Vision Dust]|h|r";
EDB_Reagent_Index[4]  = 11176;	EDB_Reagent[11176] = "|cffffffff|Hitem:11176:0:0:0|h[Dream Dust]|h|r";
EDB_Reagent_Index[5]  = 16204;	EDB_Reagent[16204] = "|cffffffff|Hitem:16204:0:0:0|h[Illusion Dust]|h|r";

-----[[ ESSENCES ]]-----
EDB_Reagent_Index[6]  = 10938;	EDB_Reagent[10938] = "|cff1eff00|Hitem:10938:0:0:0|h[Lesser Magic Essence]|h|r";
EDB_Reagent_Index[7]  = 10939;	EDB_Reagent[10939] = "|cff1eff00|Hitem:10939:0:0:0|h[Greater Magic Essence]|h|r";
EDB_Reagent_Index[8]  = 10998;	EDB_Reagent[10998] = "|cff1eff00|Hitem:10998:0:0:0|h[Lesser Astral Essence]|h|r";
EDB_Reagent_Index[9]  = 11082;	EDB_Reagent[11082] = "|cff1eff00|Hitem:11082:0:0:0|h[Greater Astral Essence]|h|r";
EDB_Reagent_Index[10] = 11134;	EDB_Reagent[11134] = "|cff1eff00|Hitem:11134:0:0:0|h[Lesser Mystic Essence]|h|r";
EDB_Reagent_Index[11] = 11135;	EDB_Reagent[11135] = "|cff1eff00|Hitem:11135:0:0:0|h[Greater Mystic Essence]|h|r";
EDB_Reagent_Index[12] = 11174;	EDB_Reagent[11174] = "|cff1eff00|Hitem:11174:0:0:0|h[Lesser Nether Essence]|h|r";
EDB_Reagent_Index[13] = 11175;	EDB_Reagent[11175] = "|cff1eff00|Hitem:11175:0:0:0|h[Greater Nether Essence]|h|r";
EDB_Reagent_Index[14] = 16202;	EDB_Reagent[16202] = "|cff1eff00|Hitem:16202:0:0:0|h[Lesser Eternal Essence]|h|r";
EDB_Reagent_Index[15] = 16203;	EDB_Reagent[16203] = "|cff1eff00|Hitem:16203:0:0:0|h[Greater Eternal Essence]|h|r";

-----[[ SHARDS ]]-----
EDB_Reagent_Index[16] = 10978;	EDB_Reagent[10978] = "|cff0070dd|Hitem:10978:0:0:0|h[Small Glimmering Shard]|h|r";
EDB_Reagent_Index[17] = 11084;	EDB_Reagent[11084] = "|cff0070dd|Hitem:11084:0:0:0|h[Large Glimmering Shard]|h|r";
EDB_Reagent_Index[18] = 11138;	EDB_Reagent[11138] = "|cff0070dd|Hitem:11138:0:0:0|h[Small Glowing Shard]|h|r";
EDB_Reagent_Index[19] = 11139;	EDB_Reagent[11139] = "|cff0070dd|Hitem:11139:0:0:0|h[Large Glowing Shard]|h|r";
EDB_Reagent_Index[20] = 11177;	EDB_Reagent[11177] = "|cff0070dd|Hitem:11177:0:0:0|h[Small Radiant Shard]|h|r";
EDB_Reagent_Index[21] = 11178;	EDB_Reagent[11178] = "|cff0070dd|Hitem:11178:0:0:0|h[Large Radiant Shard]|h|r";
EDB_Reagent_Index[22] = 14343;	EDB_Reagent[14343] = "|cff0070dd|Hitem:14343:0:0:0|h[Small Brilliant Shard]|h|r";
EDB_Reagent_Index[23] = 14344;	EDB_Reagent[14344] = "|cff0070dd|Hitem:14344:0:0:0|h[Large Brilliant Shard]|h|r";

-----[[ CRYSTALS ]]-----
EDB_Reagent_Index[24] = 20725;	EDB_Reagent[20725] = "|cffa335ee|Hitem:20725:0:0:0|h[Nexus Crystal]|h|r";

-----[[ VIALS ]]-----
EDB_Reagent_Index[25] = 3371;	EDB_Reagent[3371]  = "|cffffffff|Hitem:3371:0:0:0|h[Empty Vial]|h|r";
EDB_Reagent_Index[26] = 3372;	EDB_Reagent[3372]  = "|cffffffff|Hitem:3372:0:0:0|h[Leaded Vial]|h|r";
EDB_Reagent_Index[27] = 8925;	EDB_Reagent[8925]  = "|cffffffff|Hitem:8925:0:0:0|h[Crystal Vial]|h|r";
EDB_Reagent_Index[28] = 18256;	EDB_Reagent[18256] = "|cffffffff|Hitem:18256:0:0:0|h[Imbued Vial]|h|r";

-----[[ OTHERS ]]-----
EDB_Reagent_Index[29] = 7909;	EDB_Reagent[7909]  = "|cff1eff00|Hitem:7909:0:0:0|h[Aquamarine]|h|r";
EDB_Reagent_Index[30] = 16206;	EDB_Reagent[16206] = "|cffffffff|Hitem:16206:0:0:0|h[Arcanite Rod]|h|r";
EDB_Reagent_Index[31] = 11754;	EDB_Reagent[11754] = "|cff1eff00|Hitem:11754:0:0:0|h[Black Diamond]|h|r";
EDB_Reagent_Index[32] = 13468;	EDB_Reagent[13468] = "|cff1eff00|Hitem:13468:0:0:0|h[Black Lotus]|h|r";
EDB_Reagent_Index[33] = 7971;	EDB_Reagent[7971]  = "|cff1eff00|Hitem:7971:0:0:0|h[Black Pearl]|h|r";
EDB_Reagent_Index[34] = 6370;	EDB_Reagent[6370]  = "|cffffffff|Hitem:6370:0:0:0|h[Blackmouth Oil]|h|r";
EDB_Reagent_Index[35] = 11382;	EDB_Reagent[11382] = "|cff1eff00|Hitem:11382:0:0:0|h[Blood of the Mountain]|h|r";
EDB_Reagent_Index[36] = 7081;	EDB_Reagent[7081]  = "|cffffffff|Hitem:7081:0:0:0|h[Breath of Wind]|h|r";
EDB_Reagent_Index[37] = 6217;	EDB_Reagent[6217]  = "|cffffffff|Hitem:6217:0:0:0|h[Copper Rod]|h|r";
EDB_Reagent_Index[38] = 7075;	EDB_Reagent[7075]  = "|cffffffff|Hitem:7075:0:0:0|h[Core of Earth]|h|r";
EDB_Reagent_Index[39] = 7069;	EDB_Reagent[7069]  = "|cffffffff|Hitem:7069:0:0:0|h[Elemental Air]|h|r";
EDB_Reagent_Index[40] = 7067;	EDB_Reagent[7067]  = "|cffffffff|Hitem:7067:0:0:0|h[Elemental Earth]|h|r";
EDB_Reagent_Index[41] = 7068;	EDB_Reagent[7068]  = "|cffffffff|Hitem:7068:0:0:0|h[Elemental Fire]|h|r";
EDB_Reagent_Index[42] = 7070;	EDB_Reagent[7070]  = "|cffffffff|Hitem:7070:0:0:0|h[Elemental Water]|h|r";
EDB_Reagent_Index[43] = 9224;	EDB_Reagent[9224]  = "|cffffffff|Hitem:9224:0:0:0|h[Elixir of Demonslaying]|h|r";
EDB_Reagent_Index[44] = 7082;	EDB_Reagent[7082]  = "|cff1eff00|Hitem:7082:0:0:0|h[Essence of Air]|h|r";
EDB_Reagent_Index[45] = 7076;	EDB_Reagent[7076]  = "|cff1eff00|Hitem:7076:0:0:0|h[Essence of Earth]|h|r";
EDB_Reagent_Index[46] = 7078;	EDB_Reagent[7078]  = "|cff1eff00|Hitem:7078:0:0:0|h[Essence of Fire]|h|r";
EDB_Reagent_Index[47] = 12808;	EDB_Reagent[12808] = "|cff1eff00|Hitem:12808:0:0:0|h[Essence of Undeath]|h|r";
EDB_Reagent_Index[48] = 7080;	EDB_Reagent[7080]  = "|cff1eff00|Hitem:7080:0:0:0|h[Essence of Water]|h|r";
EDB_Reagent_Index[49] = 4625;	EDB_Reagent[4625]  = "|cffffffff|Hitem:4625:0:0:0|h[Firebloom]|h|r";
EDB_Reagent_Index[50] = 6371;	EDB_Reagent[6371]  = "|cffffffff|Hitem:6371:0:0:0|h[Fire Oil]|h|r";
EDB_Reagent_Index[51] = 3829;	EDB_Reagent[3829]  = "|cffffffff|Hitem:3829:0:0:0|h[Frost Oil]|h|r";
EDB_Reagent_Index[52] = 12809;	EDB_Reagent[12809] = "|cff1eff00|Hitem:12809:0:0:0|h[Guardian Stone]|h|r";
EDB_Reagent_Index[53] = 7079;	EDB_Reagent[7079]  = "|cffffffff|Hitem:7079:0:0:0|h[Globe of Water]|h|r";
EDB_Reagent_Index[54] = 13926;	EDB_Reagent[13926] = "|cff1eff00|Hitem:13926:0:0:0|h[Golden Pearl]|h|r";
EDB_Reagent_Index[55] = 11128;	EDB_Reagent[11128] = "|cffffffff|Hitem:11128:0:0:0|h[Golden Rod]|h|r";
EDB_Reagent_Index[56] = 7392;	EDB_Reagent[7392]  = "|cffffffff|Hitem:7392:0:0:0|h[Green Whelp Scale]|h|r";
EDB_Reagent_Index[57] = 7077;	EDB_Reagent[7077]  = "|cffffffff|Hitem:7077:0:0:0|h[Heart of Fire]|h|r";
EDB_Reagent_Index[58] = 13467;	EDB_Reagent[13467] = "|cffffffff|Hitem:13467:0:0:0|h[Icecap]|h|r";
EDB_Reagent_Index[59] = 7972;	EDB_Reagent[7972]  = "|cffffffff|Hitem:7972:0:0:0|h[Ichor of Undeath]|h|r";
EDB_Reagent_Index[60] = 5500;	EDB_Reagent[5500]  = "|cff1eff00|Hitem:5500:0:0:0|h[Iridescent Pearl]|h|r";
EDB_Reagent_Index[61] = 2772;	EDB_Reagent[2772]  = "|cffffffff|Hitem:2772:0:0:0|h[Iron Ore]|h|r";
EDB_Reagent_Index[62] = 3356;	EDB_Reagent[3356]  = "|cffffffff|Hitem:3356:0:0:0|h[Kingsblood]|h|r";
EDB_Reagent_Index[63] = 5637;	EDB_Reagent[5637]  = "|cffffffff|Hitem:5637:0:0:0|h[Large Fang]|h|r";
EDB_Reagent_Index[64] = 18512;	EDB_Reagent[18512] = "|cffffffff|Hitem:18512:0:0:0|h[Larval Acid]|h|r";
EDB_Reagent_Index[65] = 12803;	EDB_Reagent[12803] = "|cff1eff00|Hitem:12803:0:0:0|h[Living Essence]|h|r";
EDB_Reagent_Index[66] = 17034;	EDB_Reagent[17034] = "|cffffffff|Hitem:17034:0:0:0|h[Maple Seed]|h|r";
EDB_Reagent_Index[67] = 8831;	EDB_Reagent[8831]  = "|cffffffff|Hitem:8831:0:0:0|h[Purple Lotus]|h|r";
EDB_Reagent_Index[68] = 12811;	EDB_Reagent[12811] = "|cff1eff00|Hitem:12811:0:0:0|h[Righteous Orb]|h|r";
EDB_Reagent_Index[69] = 8170;	EDB_Reagent[8170]  = "|cffffffff|Hitem:8170:0:0:0|h[Rugged Leather]|h|r";
EDB_Reagent_Index[70] = 6048;	EDB_Reagent[6048]  = "|cffffffff|Hitem:6048:0:0:0|h[Shadow Protection Potion]|h|r";
EDB_Reagent_Index[71] = 1210;	EDB_Reagent[1210]  = "|cff1eff00|Hitem:1210:0:0:0|h[Shadowgem]|h|r";
EDB_Reagent_Index[72] = 6338;	EDB_Reagent[6338]  = "|cffffffff|Hitem:6338:0:0:0|h[Silver Rod]|h|r";
EDB_Reagent_Index[73] = 4470;	EDB_Reagent[4470]  = "|cffffffff|Hitem:4470:0:0:0|h[Simple Wood]|h|r";
EDB_Reagent_Index[74] = 11291;	EDB_Reagent[11291] = "|cffffffff|Hitem:11291:0:0:0|h[Star Wood]|h|r";
EDB_Reagent_Index[75] = 17035;	EDB_Reagent[17035] = "|cffffffff|Hitem:17035:0:0:0|h[Stranglethorn Seed]|h|r";
EDB_Reagent_Index[76] = 8838;	EDB_Reagent[8838]  = "|cffffffff|Hitem:8838:0:0:0|h[Sungrass]|h|r";
EDB_Reagent_Index[77] = 12359;	EDB_Reagent[12359] = "|cffffffff|Hitem:12359:0:0:0|h[Thorium Bar]|h|r";
EDB_Reagent_Index[78] = 6037;	EDB_Reagent[6037]  = "|cff1eff00|Hitem:6037:0:0:0|h[Truesilver Bar]|h|r";
EDB_Reagent_Index[79] = 11144;	EDB_Reagent[11144] = "|cffffffff|Hitem:11144:0:0:0|h[Truesilver Rod]|h|r";
EDB_Reagent_Index[80] = 8153;	EDB_Reagent[8153]  = "|cffffffff|Hitem:8153:0:0:0|h[Wildvine]|h|r";
EDB_Reagent_Index[81] = 3819;	EDB_Reagent[3819]  = "|cffffffff|Hitem:3819:0:0:0|h[Wintersbite]|h|r";

--------------[[ FORMULAS ]]--------------

EDB_Formula = {};

--EDB_Formula[] = {["name"]="", ["item"]=, ["bonusType"]=, ["bonusValue"]=, ["skill"]=, ["source"]=, ["rod"]=, ["link"]="", ["content"]={}, ["bonusText"]=""};

-----[[ BOOTS ]]-----
EDB_Formula[7867]  = {["name"]="Minor Agility",				["item"]=BOOTS,		["bonusType"]=AGI,		["bonusValue"]=1,	["skill"]=125,	["source"]=VENDOR,  ["rod"]=RSR, ["content"]={[LAE]=2, [TD]=6}};
EDB_Formula[7863]  = {["name"]="Minor Stamina",				["item"]=BOOTS,		["bonusType"]=STA,		["bonusValue"]=1,	["skill"]=125,	["source"]=TRAINER, ["rod"]=RSR, ["content"]={[TD]=8}};
EDB_Formula[13644] = {["name"]="Lesser Stamina",			["item"]=BOOTS,		["bonusType"]=STA,		["bonusValue"]=3,	["skill"]=170,	["source"]=TRAINER, ["rod"]=RGR, ["content"]={[SD]=4}};
EDB_Formula[13687] = {["name"]="Lesser Spirit",				["item"]=BOOTS,		["bonusType"]=SPI,		["bonusValue"]=3,	["skill"]=190,	["source"]=DROP,    ["rod"]=RGR, ["content"]={[GYE]=1, [LYE]=2}};
EDB_Formula[13836] = {["name"]="Stamina",					["item"]=BOOTS,		["bonusType"]=STA,		["bonusValue"]=5,	["skill"]=215,	["source"]=TRAINER, ["rod"]=RTR, ["content"]={[VD]=5}};
EDB_Formula[13890] = {["name"]="Minor Speed",				["item"]=BOOTS,		["bonusType"]=BOTHER,	["bonusValue"]=8,	["skill"]=225,	["source"]=TRAINER, ["rod"]=RTR, ["content"]={[7909]=1, [LNE]=1, [SRS]=1},	["bonusText"]="8% Speed"};
EDB_Formula[13637] = {["name"]="Lesser Agility",			["item"]=BOOTS,		["bonusType"]=AGI,		["bonusValue"]=3,	["skill"]=235,	["source"]=TRAINER, ["rod"]=RGR, ["content"]={[SD]=1,  [LYE]=1}};
EDB_Formula[13935] = {["name"]="Agility",					["item"]=BOOTS,		["bonusType"]=AGI,		["bonusValue"]=5,	["skill"]=235,	["source"]=TRAINER, ["rod"]=RTR, ["content"]={[GNE]=2}};
EDB_Formula[20020] = {["name"]="Greater Stamina",			["item"]=BOOTS,		["bonusType"]=STA,		["bonusValue"]=7,	["skill"]=260,	["source"]=DROP,    ["rod"]=RTR, ["content"]={[DD]=10}};
EDB_Formula[20024] = {["name"]="Spirit",					["item"]=BOOTS,		["bonusType"]=SPI,		["bonusValue"]=5,	["skill"]=275,	["source"]=DROP,    ["rod"]=RTR, ["content"]={[GEE]=2, [LEE]=1}};
EDB_Formula[20023] = {["name"]="Greater Agility",			["item"]=BOOTS,		["bonusType"]=AGI,		["bonusValue"]=7,	["skill"]=295,	["source"]=DROP,    ["rod"]=RTR, ["content"]={[GEE]=8}};

-----[[ BRACER ]]-----
EDB_Formula[7418]  = {["name"]="Minor Health",				["item"]=BRACER,	["bonusType"]=STAT,		["bonusValue"]=5,	["skill"]=0,	["source"]=TRAINER, ["rod"]=RCR, ["content"]={[TD]=1},						["bonusText"]="+5 HP"};
EDB_Formula[7428]  = {["name"]="Minor Deflect",				["item"]=BRACER,	["bonusType"]=STAT,		["bonusValue"]=1,	["skill"]=1,	["source"]=TRAINER, ["rod"]=RCR, ["content"]={[LME]=1, [TD]=1},				["bonusText"]="+1 Def"};
EDB_Formula[7457]  = {["name"]="Minor Stamina",				["item"]=BRACER,	["bonusType"]=STA,		["bonusValue"]=1,	["skill"]=50,	["source"]=TRAINER, ["rod"]=RCR, ["content"]={[TD]=3}};
EDB_Formula[7766]  = {["name"]="Minor Spirit",				["item"]=BRACER,	["bonusType"]=SPI,		["bonusValue"]=1,	["skill"]=60,	["source"]=DROP,    ["rod"]=RCR, ["content"]={[LME]=2}};
EDB_Formula[7779]  = {["name"]="Minor Agility",				["item"]=BRACER,	["bonusType"]=AGI,		["bonusValue"]=1,	["skill"]=80,	["source"]=TRAINER, ["rod"]=RCR, ["content"]={[GME]=1, [TD]=2}};
EDB_Formula[7782]  = {["name"]="Minor Strength",			["item"]=BRACER,	["bonusType"]=STR,		["bonusValue"]=1,	["skill"]=80,	["source"]=DROP,    ["rod"]=RCR, ["content"]={[TD]=5}};
EDB_Formula[7859]  = {["name"]="Lesser Spirit",				["item"]=BRACER,	["bonusType"]=SPI,		["bonusValue"]=3,	["skill"]=120,	["source"]=DROP,    ["rod"]=RSR, ["content"]={[LAE]=2}};
EDB_Formula[13501] = {["name"]="Lesser Stamina",			["item"]=BRACER,	["bonusType"]=STA,		["bonusValue"]=3,	["skill"]=130,	["source"]=TRAINER, ["rod"]=RSR, ["content"]={[SD]=2}};
EDB_Formula[13536] = {["name"]="Lesser Strength",			["item"]=BRACER,	["bonusType"]=STR,		["bonusValue"]=3,	["skill"]=140,	["source"]=VENDOR,  ["rod"]=RSR, ["content"]={[SD]=2}};
EDB_Formula[13622] = {["name"]="Lesser Intellect",			["item"]=BRACER,	["bonusType"]=INT,		["bonusValue"]=3,	["skill"]=150,	["source"]=TRAINER, ["rod"]=RSR, ["content"]={[GAE]=2}};
EDB_Formula[13642] = {["name"]="Spirit",					["item"]=BRACER,	["bonusType"]=SPI,		["bonusValue"]=5,	["skill"]=165,	["source"]=TRAINER, ["rod"]=RGR, ["content"]={[LYE]=1}};
EDB_Formula[13646] = {["name"]="Lesser Deflection",			["item"]=BRACER,	["bonusType"]=STAT,		["bonusValue"]=2,	["skill"]=170,	["source"]=VENDOR,  ["rod"]=RGR, ["content"]={[LYE]=1, [SD]=2},				["bonusText"]="+2 Def"};
EDB_Formula[13648] = {["name"]="Stamina",					["item"]=BRACER,	["bonusType"]=STA,		["bonusValue"]=5,	["skill"]=170,	["source"]=TRAINER, ["rod"]=RGR, ["content"]={[SD]=6}};
EDB_Formula[13661] = {["name"]="Strength",					["item"]=BRACER,	["bonusType"]=STR,		["bonusValue"]=5,	["skill"]=180,	["source"]=TRAINER, ["rod"]=RGR, ["content"]={[VD]=1}};
EDB_Formula[13822] = {["name"]="Intellect",					["item"]=BRACER,	["bonusType"]=INT,		["bonusValue"]=5,	["skill"]=210,	["source"]=TRAINER, ["rod"]=RTR, ["content"]={[LNE]=2}};
EDB_Formula[13846] = {["name"]="Greater Spirit",			["item"]=BRACER,	["bonusType"]=SPI,		["bonusValue"]=7,	["skill"]=220,	["source"]=DROP,    ["rod"]=RTR, ["content"]={[LNE]=3, [VD]=1}};
EDB_Formula[13931] = {["name"]="Deflection",				["item"]=BRACER,	["bonusType"]=STAT,		["bonusValue"]=3,	["skill"]=235,	["source"]=VENDOR,  ["rod"]=RTR, ["content"]={[GNE]=1, [DD]=2},				["bonusText"]="+3 Def"};
EDB_Formula[13939] = {["name"]="Greater Strength",			["item"]=BRACER,	["bonusType"]=STR,		["bonusValue"]=7,	["skill"]=240,	["source"]=TRAINER, ["rod"]=RTR, ["content"]={[GNE]=1, [DD]=2}};
EDB_Formula[13945] = {["name"]="Greater Stamina",			["item"]=BRACER,	["bonusType"]=STA,		["bonusValue"]=7,	["skill"]=245,	["source"]=DROP,    ["rod"]=RTR, ["content"]={[DD]=5}};
EDB_Formula[20008] = {["name"]="Greater Intellect",			["item"]=BRACER,	["bonusType"]=INT,		["bonusValue"]=7,	["skill"]=255,	["source"]=DROP,    ["rod"]=RTR, ["content"]={[LEE]=3}};
EDB_Formula[20009] = {["name"]="Superior Spirit",			["item"]=BRACER,	["bonusType"]=SPI,		["bonusValue"]=9,	["skill"]=270,	["source"]=DROP,    ["rod"]=RTR, ["content"]={[LEE]=3, [DD]=10}};
EDB_Formula[23801] = {["name"]="Mana Regeneration",			["item"]=BRACER,	["bonusType"]=BOTHER,	["bonusValue"]=4,	["skill"]=290,	["source"]=VENDOR,  ["rod"]=RAR, ["content"]={[ID]=16, [GEE]=4, [7080]=2},		["bonusText"]="+4 mp/5s"};
EDB_Formula[20010] = {["name"]="Superior Strength",			["item"]=BRACER,	["bonusType"]=STR,		["bonusValue"]=9,	["skill"]=295,	["source"]=DROP,    ["rod"]=RTR, ["content"]={[GEE]=6, [ID]=6}};
EDB_Formula[20011] = {["name"]="Superior Stamina",			["item"]=BRACER,	["bonusType"]=STA,		["bonusValue"]=9,	["skill"]=300,	["source"]=DROP,    ["rod"]=RTR, ["content"]={[ID]=15}};
EDB_Formula[23802] = {["name"]="Healing Power",				["item"]=BRACER,	["bonusType"]=BOTHER,	["bonusValue"]=24,	["skill"]=300,	["source"]=VENDOR,  ["rod"]=RAR, ["content"]={[LBS]=2, [ID]=20, [GEE]=4, [12803]=6},	["bonusText"]="+24 Heal"};

-----[[ CHEST ]]-----
EDB_Formula[7420]  = {["name"]="Minor Health",				["item"]=CHEST,		["bonusType"]=STAT,		["bonusValue"]=5,	["skill"]=15,	["source"]=TRAINER, ["rod"]=RCR, ["content"]={[TD]=1},						["bonusText"]="+5 HP"};
EDB_Formula[7443]  = {["name"]="Minor Mana",				["item"]=CHEST,		["bonusType"]=STAT,		["bonusValue"]=5,	["skill"]=20,	["source"]=VENDOR,  ["rod"]=RCR, ["content"]={[LME]=1},						["bonusText"]="+5 MP"};
EDB_Formula[7426]  = {["name"]="Minor Absorption",			["item"]=CHEST,		["bonusType"]=PROC,		["bonusValue"]=2,	["skill"]=40,	["source"]=TRAINER, ["rod"]=RCR, ["content"]={[TD]=2, [LME]=1},				["bonusText"]="2% 10 DR"};
EDB_Formula[7748]  = {["name"]="Lesser Health",				["item"]=CHEST,		["bonusType"]=STAT,		["bonusValue"]=15,	["skill"]=60,	["source"]=TRAINER, ["rod"]=RCR, ["content"]={[TD]=2, [LME]=2},				["bonusText"]="+15 HP"};
EDB_Formula[7776]  = {["name"]="Lesser Mana",				["item"]=CHEST,		["bonusType"]=STAT,		["bonusValue"]=20,	["skill"]=80,	["source"]=VENDOR,  ["rod"]=RCR, ["content"]={[GME]=1, [LME]=1},			["bonusText"]="+20 MP"};
EDB_Formula[7857]  = {["name"]="Health",					["item"]=CHEST,		["bonusType"]=STAT,		["bonusValue"]=25,	["skill"]=120,	["source"]=TRAINER, ["rod"]=RSR, ["content"]={[TD]=4, [LAE]=1},				["bonusText"]="+25 HP"};
EDB_Formula[13538] = {["name"]="Lesser Absorption",			["item"]=CHEST,		["bonusType"]=PROC,		["bonusValue"]=5,	["skill"]=140,	["source"]=TRAINER, ["rod"]=RSR, ["content"]={[TD]=2, [GAE]=1, [LGS]=1},	["bonusText"]="5% 25 DR"};
EDB_Formula[13607] = {["name"]="Mana",						["item"]=CHEST,		["bonusType"]=STAT,		["bonusValue"]=30,	["skill"]=145,	["source"]=TRAINER, ["rod"]=RSR, ["content"]={[GAE]=1, [LAE]=2},			["bonusText"]="+30 MP"};
EDB_Formula[13626] = {["name"]="Minor Stats",				["item"]=CHEST,		["bonusType"]=STAT,		["bonusValue"]=1,	["skill"]=150,	["source"]=TRAINER, ["rod"]=RSR, ["content"]={[GAE]=1, [SD]=1, [LGS]=1}, 	["bonusText"]="+1 Stats"};
EDB_Formula[13640] = {["name"]="Greater Health",			["item"]=CHEST,		["bonusType"]=STAT,		["bonusValue"]=35,	["skill"]=160,	["source"]=TRAINER, ["rod"]=RGR, ["content"]={[SD]=3},						["bonusText"]="+35 HP"};
EDB_Formula[13663] = {["name"]="Greater Mana",				["item"]=CHEST,		["bonusType"]=STAT,		["bonusValue"]=50,	["skill"]=185,	["source"]=TRAINER, ["rod"]=RGR, ["content"]={[GYE]=1},						["bonusText"]="+50 MP"};
EDB_Formula[13700] = {["name"]="Lesser Stats",				["item"]=CHEST,		["bonusType"]=STAT,		["bonusValue"]=2,	["skill"]=200,	["source"]=TRAINER, ["rod"]=RGR, ["content"]={[GYE]=2, [VD]=2, [LWS]=1},	["bonusText"]="+2 Stats"};
EDB_Formula[13858] = {["name"]="Superior Health",			["item"]=CHEST,		["bonusType"]=STAT,		["bonusValue"]=50,	["skill"]=220,	["source"]=TRAINER, ["rod"]=RTR, ["content"]={[VD]=6},						["bonusText"]="+50 HP"};
EDB_Formula[13917] = {["name"]="Superior Mana",				["item"]=CHEST,		["bonusType"]=STAT,		["bonusValue"]=65,	["skill"]=230,	["source"]=TRAINER, ["rod"]=RTR, ["content"]={[GNE]=1, [LNE]=2},			["bonusText"]="+65 MP"};
EDB_Formula[13941] = {["name"]="Stats",						["item"]=CHEST,		["bonusType"]=STAT,		["bonusValue"]=3,	["skill"]=245,	["source"]=TRAINER, ["rod"]=RTR, ["content"]={[LRS]=1, [DD]=3, [GNE]=2},	["bonusText"]="+3 Stats"};
EDB_Formula[20026] = {["name"]="Major Health",				["item"]=CHEST,		["bonusType"]=STAT,		["bonusValue"]=100,	["skill"]=275,	["source"]=VENDOR,  ["rod"]=RTR, ["content"]={[ID]=6, [SBS]=1},				["bonusText"]="+100 HP"};
EDB_Formula[20028] = {["name"]="Major Mana",				["item"]=CHEST,		["bonusType"]=STAT,		["bonusValue"]=100,	["skill"]=290,	["source"]=DROP,    ["rod"]=RTR, ["content"]={[GEE]=3, [SBS]=1},			["bonusText"]="+100 MP"};
EDB_Formula[20025] = {["name"]="Greater Stats",				["item"]=CHEST,		["bonusType"]=STAT,		["bonusValue"]=4,	["skill"]=300,	["source"]=DROP,    ["rod"]=RAR, ["content"]={[LBS]=4, [ID]=15, [GEE]=10},	["bonusText"]="+4 Stats"};

-----[[ CLOAK ]]-----
EDB_Formula[7454]  = {["name"]="Minor Resistance",			["item"]=CLOAK,		["bonusType"]=RES,		["bonusValue"]=1,	["skill"]=45,	["source"]=TRAINER, ["rod"]=RCR, ["content"]={[TD]=1, [LME]=2},				["bonusText"]="+1 Res"};
EDB_Formula[7771]  = {["name"]="Minor Protection",			["item"]=CLOAK,		["bonusType"]=STAT,		["bonusValue"]=10,	["skill"]=91,	["source"]=TRAINER, ["rod"]=RCR, ["content"]={[TD]=3, [GME]=1},				["bonusText"]="10 Armor"};
EDB_Formula[13419] = {["name"]="Minor Agility",				["item"]=CLOAK,		["bonusType"]=AGI,		["bonusValue"]=1,	["skill"]=110,	["source"]=VENDOR,  ["rod"]=RSR, ["content"]={[LAE]=1}};
EDB_Formula[13421] = {["name"]="Lesser Protection",			["item"]=CLOAK,		["bonusType"]=STAT,		["bonusValue"]=20,	["skill"]=115,	["source"]=TRAINER, ["rod"]=RCR, ["content"]={[TD]=6, [SGS]=1},				["bonusText"]="20 Armor"};
EDB_Formula[7861]  = {["name"]="Lesser Fire Resistance",	["item"]=CLOAK,		["bonusType"]=RES,		["bonusValue"]=5,	["skill"]=125,	["source"]=TRAINER, ["rod"]=RSR, ["content"]={[LAE]=1, [6371]=1},			["bonusText"]="+5 FR"};
EDB_Formula[13522] = {["name"]="Lesser Shadow Resistance",	["item"]=CLOAK,		["bonusType"]=RES,		["bonusValue"]=10,	["skill"]=135,	["source"]=DROP,    ["rod"]=RSR, ["content"]={[GAE]=1, [6048]=1},			["bonusText"]="+10 SR"};
EDB_Formula[13635] = {["name"]="Defense",					["item"]=CLOAK,		["bonusType"]=STAT,		["bonusValue"]=30,	["skill"]=155,	["source"]=TRAINER, ["rod"]=RGR, ["content"]={[SWS]=1, [SD]=3},				["bonusText"]="30 Armor"};
EDB_Formula[13657] = {["name"]="Fire Resistance",			["item"]=CLOAK,		["bonusType"]=RES,		["bonusValue"]=7,	["skill"]=175,	["source"]=TRAINER, ["rod"]=RGR, ["content"]={[LYE]=1, [7068]=1},			["bonusText"]="+7 FR"};
EDB_Formula[13746] = {["name"]="Greater Defense",			["item"]=CLOAK,		["bonusType"]=STAT,		["bonusValue"]=50,	["skill"]=205,	["source"]=TRAINER, ["rod"]=RTR, ["content"]={[VD]=3}, 						["bonusText"]="50 Armor"};
EDB_Formula[13794] = {["name"]="Resistance",				["item"]=CLOAK,		["bonusType"]=RES,		["bonusValue"]=3,	["skill"]=205,	["source"]=TRAINER, ["rod"]=RTR, ["content"]={[LNE]=1}, 					["bonusText"]="+3 Res"};
EDB_Formula[13882] = {["name"]="Lesser Agility",			["item"]=CLOAK,		["bonusType"]=AGI,		["bonusValue"]=3,	["skill"]=225,	["source"]=DROP,    ["rod"]=RTR, ["content"]={[LNE]=2}};
EDB_Formula[20014] = {["name"]="Greater Resistance",		["item"]=CLOAK,		["bonusType"]=RES,		["bonusValue"]=5,	["skill"]=265,	["source"]=DROP,    ["rod"]=RTR, ["content"]={[LEE]=2, [7081]=1, [7075]=1, [7079]=1, [7077]=1, [7972]=1}, ["bonusText"]="+5 Res"};
EDB_Formula[20015] = {["name"]="Superior Defense",			["item"]=CLOAK,		["bonusType"]=STAT,		["bonusValue"]=70,	["skill"]=285,	["source"]=VENDOR,  ["rod"]=RTR, ["content"]={[ID]=8}, 						["bonusText"]="70 Armor"};
EDB_Formula[25081] = {["name"]="Greater Fire Resistance",	["item"]=CLOAK,		["bonusType"]=RES,		["bonusValue"]=15,	["skill"]=300,	["source"]=VENDOR, 	["rod"]=RAR, ["content"]={[LBS]=8, [NC]=3, [7078]=4},	["bonusText"]="+15 FR"};
EDB_Formula[25082] = {["name"]="Greater Nature Resistance",	["item"]=CLOAK,		["bonusType"]=RES,		["bonusValue"]=15,	["skill"]=300,	["source"]=VENDOR, 	["rod"]=RAR, ["content"]={[LBS]=8, [NC]=2, [12803]=4},	["bonusText"]="+15 NR"};
EDB_Formula[25083] = {["name"]="Stealth",					["item"]=CLOAK,		["bonusType"]=STAT,		["bonusValue"]=1,	["skill"]=300,	["source"]=DROP,	["rod"]=RAR, ["content"]={[LBS]=8, [NC]=3, [13468]=2},	["bonusText"]="Stealth"};
EDB_Formula[25084] = {["name"]="Subtlety",					["item"]=CLOAK,		["bonusType"]=BOTHER,	["bonusValue"]=2,	["skill"]=300,	["source"]=DROP,	["rod"]=RAR, ["content"]={[LBS]=6, [NC]=4, [11754]=2},	["bonusText"]="-2% Threat"};
EDB_Formula[25086] = {["name"]="Dodge",						["item"]=CLOAK,		["bonusType"]=STAT,		["bonusValue"]=1,	["skill"]=300,	["source"]=DROP,	["rod"]=RAR, ["content"]={[NC]=3, [LBS]=8, [12809]=8},	["bonusText"]="1% Dodge"};

-----[[ GLOVES ]]-----
EDB_Formula[13620] = {["name"]="Fishing",					["item"]=GLOVES,	["bonusType"]=BOTHER,	["bonusValue"]=2,	["skill"]=145,	["source"]=DROP,    ["rod"]=RSR, ["content"]={[SD]=1,   [6370]=3},			["bonusText"]="+2 Fish"};
EDB_Formula[13617] = {["name"]="Herbalism",					["item"]=GLOVES,	["bonusType"]=BOTHER,	["bonusValue"]=2,	["skill"]=145,	["source"]=DROP,    ["rod"]=RSR, ["content"]={[SD]=1,   [3356]=3},			["bonusText"]="+2 Herb"};
EDB_Formula[13612] = {["name"]="Mining",					["item"]=GLOVES,	["bonusType"]=BOTHER,	["bonusValue"]=2,	["skill"]=145,	["source"]=DROP,    ["rod"]=RSR, ["content"]={[SD]=1,   [2772]=3},			["bonusText"]="+2 Mine"};
EDB_Formula[13698] = {["name"]="Skinning",					["item"]=GLOVES,	["bonusType"]=BOTHER,	["bonusValue"]=5,	["skill"]=200,	["source"]=DROP,    ["rod"]=RGR, ["content"]={[VD]=1,   [7392]=3},			["bonusText"]="+5 Skin"};
EDB_Formula[13815] = {["name"]="Agility",					["item"]=GLOVES,	["bonusType"]=AGI,		["bonusValue"]=5,	["skill"]=210,	["source"]=TRAINER, ["rod"]=RTR, ["content"]={[LNE]=1,  [VD]=1}};
EDB_Formula[13841] = {["name"]="Advanced Mining",			["item"]=GLOVES,	["bonusType"]=BOTHER,	["bonusValue"]=5,	["skill"]=215,	["source"]=DROP,    ["rod"]=RTR, ["content"]={[VD]=3,   [6037]=3},			["bonusText"]="+5 Mine"};
EDB_Formula[13868] = {["name"]="Advanced Herbalism",		["item"]=GLOVES,	["bonusType"]=BOTHER,	["bonusValue"]=5,	["skill"]=225,	["source"]=DROP,    ["rod"]=RTR, ["content"]={[VD]=3,   [8838]=3},			["bonusText"]="+5 Herb"};
EDB_Formula[13887] = {["name"]="Strength",					["item"]=GLOVES,	["bonusType"]=STR,		["bonusValue"]=5,	["skill"]=225,	["source"]=TRAINER, ["rod"]=RTR, ["content"]={[LNE]=2,  [VD]=3}};
EDB_Formula[13948] = {["name"]="Minor Haste",				["item"]=GLOVES,	["bonusType"]=BOTHER,	["bonusValue"]=1,	["skill"]=250,	["source"]=TRAINER, ["rod"]=RTR, ["content"]={[LRS]=2,  [8153]=2},			["bonusText"]="1% Haste"};
EDB_Formula[13947] = {["name"]="Riding Skill",				["item"]=GLOVES,	["bonusType"]=BOTHER,	["bonusValue"]=2,	["skill"]=250,	["source"]=DROP,    ["rod"]=RTR, ["content"]={[LRS]=2,  [DD]=3},			["bonusText"]="2% Mount"};
EDB_Formula[20012] = {["name"]="Greater Agility",			["item"]=GLOVES,	["bonusType"]=AGI,		["bonusValue"]=7,	["skill"]=270,	["source"]=DROP,    ["rod"]=RTR, ["content"]={[LEE]=3,  [ID]=3}};
EDB_Formula[20013] = {["name"]="Greater Strength",			["item"]=GLOVES,	["bonusType"]=STR,		["bonusValue"]=7,	["skill"]=295,	["source"]=DROP,    ["rod"]=RTR, ["content"]={[GEE]=4,  [ID]=4}};
EDB_Formula[25072] = {["name"]="Threat",					["item"]=GLOVES,	["bonusType"]=BOTHER,	["bonusValue"]=2,	["skill"]=300,	["source"]=DROP,	["rod"]=RAR, ["content"]={[LBS]=6,  [NC]=4, [18512]=8},	["bonusText"]="+2% Threat"};
EDB_Formula[25073] = {["name"]="Shadow Power",				["item"]=GLOVES,	["bonusType"]=BOTHER,	["bonusValue"]=20,	["skill"]=300,	["source"]=DROP,	["rod"]=RAR, ["content"]={[LBS]=10, [NC]=3, [12808]=6},	["bonusText"]="+20 Shdw"};
EDB_Formula[25074] = {["name"]="Frost Power",				["item"]=GLOVES,	["bonusType"]=BOTHER,	["bonusValue"]=20,	["skill"]=300,	["source"]=DROP,	["rod"]=RAR, ["content"]={[LBS]=10, [NC]=3, [7080]=4},	["bonusText"]="+20 Frost"};
EDB_Formula[25078] = {["name"]="Fire Power",				["item"]=GLOVES,	["bonusType"]=BOTHER,	["bonusValue"]=20,	["skill"]=300,	["source"]=DROP,	["rod"]=RAR, ["content"]={[LBS]=10, [NC]=2, [7078]=4},	["bonusText"]="+20 Fire"};
EDB_Formula[25079] = {["name"]="Healing Power",				["item"]=GLOVES,	["bonusType"]=BOTHER,	["bonusValue"]=30,	["skill"]=300,	["source"]=DROP,	["rod"]=RAR, ["content"]={[LBS]=8,  [NC]=3, [12811]=1},	["bonusText"]="+30 Heal"};
EDB_Formula[25080] = {["name"]="Superior Agility",			["item"]=GLOVES,	["bonusType"]=AGI,		["bonusValue"]=15,	["skill"]=300,	["source"]=DROP,	["rod"]=RAR, ["content"]={[LBS]=8,  [NC]=3, [7082]=4}};

-----[[ SHIELD ]]-----
EDB_Formula[13378] = {["name"]="Minor Stamina",				["item"]=SHIELD,	["bonusType"]=STA,		["bonusValue"]=1,	["skill"]=-1,	["source"]=-1,		["rod"]=RCR, ["content"]={[LAE]=1, [SD]=2}};
EDB_Formula[13464] = {["name"]="Lesser Protection",			["item"]=SHIELD,	["bonusType"]=STAT,		["bonusValue"]=30,	["skill"]=115,	["source"]=DROP,    ["rod"]=RSR, ["content"]={[LAE]=1, [TD]=1, [SGS]=1},	["bonusText"]="30 Armor"};
EDB_Formula[13485] = {["name"]="Lesser Spirit",				["item"]=SHIELD,	["bonusType"]=SPI,		["bonusValue"]=3,	["skill"]=130,	["source"]=TRAINER, ["rod"]=RSR, ["content"]={[LAE]=2, [TD]=4}};
EDB_Formula[13631] = {["name"]="Lesser Stamina",			["item"]=SHIELD,	["bonusType"]=STA,		["bonusValue"]=3,	["skill"]=155,	["source"]=TRAINER, ["rod"]=RGR, ["content"]={[LYE]=1, [SD]=1}};
EDB_Formula[13659] = {["name"]="Spirit",					["item"]=SHIELD,	["bonusType"]=SPI,		["bonusValue"]=5,	["skill"]=180,	["source"]=TRAINER, ["rod"]=RGR, ["content"]={[GYE]=1, [VD]=1}};
EDB_Formula[13689] = {["name"]="Lesser Block",				["item"]=SHIELD,	["bonusType"]=STAT,		["bonusValue"]=2,	["skill"]=195,	["source"]=DROP,    ["rod"]=RGR, ["content"]={[GYE]=2, [VD]=2, [LWS]=1},	["bonusText"]="2% Block"};
EDB_Formula[13817] = {["name"]="Stamina",					["item"]=SHIELD,	["bonusType"]=STA,		["bonusValue"]=5,	["skill"]=210,	["source"]=DROP,    ["rod"]=RTR, ["content"]={[VD]=5}};
EDB_Formula[13905] = {["name"]="Greater Spirit",			["item"]=SHIELD,	["bonusType"]=SPI,		["bonusValue"]=7,	["skill"]=230,	["source"]=TRAINER, ["rod"]=RTR, ["content"]={[GNE]=1, [DD]=2}};
EDB_Formula[13933] = {["name"]="Frost Resistance",			["item"]=SHIELD,	["bonusType"]=RES,		["bonusValue"]=8,	["skill"]=235,	["source"]=DROP,    ["rod"]=RTR, ["content"]={[LRS]=1, [3829]=1},			["bonusText"]="+8 FrR"};
EDB_Formula[20017] = {["name"]="Greater Stamina",			["item"]=SHIELD,	["bonusType"]=STA,		["bonusValue"]=7,	["skill"]=265,	["source"]=VENDOR,  ["rod"]=RTR, ["content"]={[DD]=10}};
EDB_Formula[20016] = {["name"]="Superior Spirit",			["item"]=SHIELD,	["bonusType"]=SPI,		["bonusValue"]=9,	["skill"]=280,	["source"]=DROP,    ["rod"]=RTR, ["content"]={[GEE]=2, [ID]=4}};

-----[[ 2H WEAPON ]]-----
EDB_Formula[7793]  = {["name"]="Lesser Intellect",			["item"]=WEAPON2H,	["bonusType"]=INT,		["bonusValue"]=3,	["skill"]=100, ["source"]=VENDOR,	["rod"]=RCR, ["content"]={[GME]=3}};
EDB_Formula[7745]  = {["name"]="Minor Impact",				["item"]=WEAPON2H,	["bonusType"]=DMG,		["bonusValue"]=2,	["skill"]=100, ["source"]=TRAINER,	["rod"]=RCR, ["content"]={[TD]=4,  [SGS]=1}};
EDB_Formula[13380] = {["name"]="Lesser Spirit",				["item"]=WEAPON2H,	["bonusType"]=SPI,		["bonusValue"]=3,	["skill"]=110, ["source"]=DROP,		["rod"]=RCR, ["content"]={[LAE]=1, [TD]=6}};
EDB_Formula[13529] = {["name"]="Lesser Impact",				["item"]=WEAPON2H,	["bonusType"]=DMG,		["bonusValue"]=3,	["skill"]=145, ["source"]=TRAINER,	["rod"]=RSR, ["content"]={[SD]=3,  [LGS]=1}};
EDB_Formula[13695] = {["name"]="Impact",					["item"]=WEAPON2H,	["bonusType"]=DMG,		["bonusValue"]=5,	["skill"]=200, ["source"]=TRAINER,	["rod"]=RGR, ["content"]={[VD]=4,  [LWS]=1}};
EDB_Formula[13937] = {["name"]="Greater Impact",			["item"]=WEAPON2H,	["bonusType"]=DMG,		["bonusValue"]=7,	["skill"]=240, ["source"]=TRAINER,	["rod"]=RTR, ["content"]={[DD]=2,  [LRS]=2}};
EDB_Formula[20030] = {["name"]="Superior Impact",			["item"]=WEAPON2H,	["bonusType"]=DMG,		["bonusValue"]=9,	["skill"]=295, ["source"]=DROP,		["rod"]=RAR, ["content"]={[LBS]=4, [ID]=10}};
EDB_Formula[20035] = {["name"]="Major Spirit",				["item"]=WEAPON2H,	["bonusType"]=SPI,		["bonusValue"]=9,	["skill"]=300, ["source"]=DROP,		["rod"]=RAR, ["content"]={[GEE]=12, [LBS]=2}};
EDB_Formula[20036] = {["name"]="Major Intellect",			["item"]=WEAPON2H,	["bonusType"]=INT,		["bonusValue"]=9,	["skill"]=300, ["source"]=DROP,		["rod"]=RAR, ["content"]={[GEE]=12, [LBS]=2}};
EDB_Formula[27837] = {["name"]="Agility",					["item"]=WEAPON2H,	["bonusType"]=AGI,		["bonusValue"]=25,	["skill"]=300, ["source"]=VENDOR,	["rod"]=RAR, ["content"]={[LBS]=10, [GEE]=6, [ID]=14, [7082]=4}};

-----[[ WEAPON ]]-----
EDB_Formula[7786]  = {["name"]="Minor Beastslayer",			["item"]=WEAPON,	["bonusType"]=DMG,		["bonusValue"]=2,	["skill"]=90,  ["source"]=DROP,		["rod"]=RCR, ["content"]={[TD]=4,  [GME]=2}};
EDB_Formula[7788]  = {["name"]="Minor Striking",			["item"]=WEAPON,	["bonusType"]=DMG,		["bonusValue"]=1,	["skill"]=90,  ["source"]=TRAINER,	["rod"]=RCR, ["content"]={[TD]=2,  [GME]=1, [SGS]=1}};
EDB_Formula[13503] = {["name"]="Lesser Striking",			["item"]=WEAPON,	["bonusType"]=DMG,		["bonusValue"]=2,	["skill"]=140, ["source"]=TRAINER,	["rod"]=RSR, ["content"]={[SD]=2,  [LGS]=1}};
EDB_Formula[13653] = {["name"]="Lesser Beastslayer",		["item"]=WEAPON,	["bonusType"]=DMG,		["bonusValue"]=6,	["skill"]=175, ["source"]=DROP,		["rod"]=RGR, ["content"]={[LYE]=1, [5637]=2, [SWS]=1}};
EDB_Formula[13655] = {["name"]="Lesser Elemental Slayer",	["item"]=WEAPON,	["bonusType"]=DMG,		["bonusValue"]=6,	["skill"]=175, ["source"]=DROP,		["rod"]=RGR, ["content"]={[LYE]=1, [7067]=1, [SWS]=1}};
EDB_Formula[21931] = {["name"]="Winter's Might",			["item"]=WEAPON,	["bonusType"]=BOTHER,	["bonusValue"]=5,	["skill"]=190, ["source"]=DROP,		["rod"]=RGR, ["content"]={[GYE]=3, [VD]=3, [LGS]=1, [3819]=2},							["bonusText"]="+5 Frost"};
EDB_Formula[13693] = {["name"]="Striking",					["item"]=WEAPON,	["bonusType"]=DMG,		["bonusValue"]=3,	["skill"]=195, ["source"]=TRAINER,	["rod"]=RGR, ["content"]={[GYE]=2, [LWS]=1}};
EDB_Formula[13915] = {["name"]="Demonslaying",				["item"]=WEAPON,	["bonusType"]=PROC,		["bonusValue"]=0,	["skill"]=230, ["source"]=DROP,		["rod"]=RTR, ["content"]={[SRS]=1, [DD]=2, [9224]=1},									["bonusText"]="Proc"};
EDB_Formula[13943] = {["name"]="Greater Striking",			["item"]=WEAPON,	["bonusType"]=DMG,		["bonusValue"]=4,	["skill"]=245, ["source"]=TRAINER,	["rod"]=RTR, ["content"]={[LRS]=2, [GNE]=2}};
EDB_Formula[13898] = {["name"]="Fiery Weapon",				["item"]=WEAPON,	["bonusType"]=PROC,		["bonusValue"]=0,	["skill"]=265, ["source"]=DROP,		["rod"]=RTR, ["content"]={[SRS]=4, [7078]=1},											["bonusText"]="Proc"};
EDB_Formula[20029] = {["name"]="Icy Chill",					["item"]=WEAPON,	["bonusType"]=PROC,		["bonusValue"]=0,	["skill"]=285, ["source"]=DROP,		["rod"]=RTR, ["content"]={[SBS]=4, [7082]=1, [7080]=1, [13467]=1},						["bonusText"]="Proc"};
EDB_Formula[23800] = {["name"]="Agility",					["item"]=WEAPON,	["bonusType"]=AGI,		["bonusValue"]=15,	["skill"]=290, ["source"]=VENDOR,	["rod"]=RAR, ["content"]={[LBS]=6, [7082]=2, [GEE]=6, [ID]=4}};
EDB_Formula[23799] = {["name"]="Strength",					["item"]=WEAPON,	["bonusType"]=STR,		["bonusValue"]=15,	["skill"]=290, ["source"]=VENDOR,	["rod"]=RAR, ["content"]={[LBS]=6, [GEE]=6, [ID]=4, [7076]=2}};
EDB_Formula[20033] = {["name"]="Unholy Weapon",				["item"]=WEAPON,	["bonusType"]=PROC,		["bonusValue"]=0,	["skill"]=295, ["source"]=DROP,		["rod"]=RAR, ["content"]={[LBS]=4, [12808]=4},											["bonusText"]="Proc"};
EDB_Formula[20034] = {["name"]="Crusader",					["item"]=WEAPON,	["bonusType"]=PROC,		["bonusValue"]=0,	["skill"]=300, ["source"]=DROP,		["rod"]=RAR, ["content"]={[LBS]=4, [12811]=2},											["bonusText"]="Proc"};
EDB_Formula[22750] = {["name"]="Healing Power",				["item"]=WEAPON,	["bonusType"]=BOTHER,	["bonusValue"]=55,	["skill"]=300, ["source"]=DROP,		["rod"]=RAR, ["content"]={[LBS]=4, [GEE]=8, [7080]=6, [12803]=6, [12811]=1},			["bonusText"]="+55 Heal",	["typo"]="Enchant  Weapon - Healing Power"};
EDB_Formula[20032] = {["name"]="Lifestealing",				["item"]=WEAPON,	["bonusType"]=PROC,		["bonusValue"]=0,	["skill"]=300, ["source"]=DROP,		["rod"]=RAR, ["content"]={[LBS]=6, [12808]=6, [12803]=6},								["bonusText"]="Proc"};
EDB_Formula[22749] = {["name"]="Spell Power",				["item"]=WEAPON,	["bonusType"]=BOTHER,	["bonusValue"]=30,	["skill"]=300, ["source"]=DROP,		["rod"]=RAR, ["content"]={[LBS]=4, [GEE]=12, [7082]=4, [7078]=4, [7080]=4, [13926]=2},	["bonusText"]="+30 d/h",	["typo"]="Enchant  Weapon - Spell Power"};
EDB_Formula[20031] = {["name"]="Superior Striking",			["item"]=WEAPON,	["bonusType"]=DMG,		["bonusValue"]=5,	["skill"]=300, ["source"]=DROP,		["rod"]=RAR, ["content"]={[LBS]=2, [GEE]=10}};
EDB_Formula[23803] = {["name"]="Mighty Spirit",				["item"]=WEAPON,	["bonusType"]=SPI,		["bonusValue"]=20,	["skill"]=300, ["source"]=VENDOR,	["rod"]=RAR, ["content"]={[LBS]=10, [GEE]=8, [ID]=15}};
EDB_Formula[23804] = {["name"]="Mighty Intellect",			["item"]=WEAPON,	["bonusType"]=INT,		["bonusValue"]=22,	["skill"]=300, ["source"]=VENDOR,	["rod"]=RAR, ["content"]={[LBS]=15, [GEE]=12, [ID]=20}};

-----[[ CREATE OIL ]]-----
EDB_Formula[25124] = {["name"]="Minor Wizard Oil",			["item"]=OIL,		["bonusType"]=ITEM,		["bonusValue"]=8,	["skill"]=45,	["source"]=VENDOR,	["rod"]=RCR, ["content"]={[SD]=2,  [EV]=1, [17034]=1},	["bonusText"]="+8 d/h",		["itemLink"]="|cffffffff|Hitem:20744:0:0:0|h[Minor Wizard Oil]|h|r"};
EDB_Formula[25125] = {["name"]="Minor Mana Oil",			["item"]=OIL,		["bonusType"]=ITEM,		["bonusValue"]=4,	["skill"]=150,	["source"]=VENDOR,	["rod"]=RSR, ["content"]={[SD]=3,  [LV]=1, [17034]=2},	["bonusText"]="4 mp/5s",	["itemLink"]="|cffffffff|Hitem:20745:0:0:0|h[Minor Mana Oil]|h|r"};
EDB_Formula[25126] = {["name"]="Lesser Wizard Oil",			["item"]=OIL,		["bonusType"]=ITEM,		["bonusValue"]=16,	["skill"]=200,	["source"]=VENDOR,	["rod"]=RGR, ["content"]={[VD]=3,  [LV]=1, [17035]=2},	["bonusText"]="+16 d/h",	["itemLink"]="|cffffffff|Hitem:20746:0:0:0|h[Lesser Wizard Oil]|h|r"};
EDB_Formula[25127] = {["name"]="Lesser Mana Oil",			["item"]=OIL,		["bonusType"]=ITEM,		["bonusValue"]=8,	["skill"]=250,	["source"]=VENDOR,	["rod"]=RTR, ["content"]={[DD]=3,  [CV]=1, [8831]=2},	["bonusText"]="8 mp/5s",	["itemLink"]="|cffffffff|Hitem:20747:0:0:0|h[Lesser Mana Oil]|h|r"};
EDB_Formula[25128] = {["name"]="Wizard Oil",				["item"]=OIL,		["bonusType"]=ITEM,		["bonusValue"]=24,	["skill"]=275,	["source"]=VENDOR,	["rod"]=RTR, ["content"]={[ID]=3,  [CV]=1, [4625]=2},	["bonusText"]="+24 d/h",	["itemLink"]="|cffffffff|Hitem:20750:0:0:0|h[Wizard Oil]|h|r"};
EDB_Formula[25129] = {["name"]="Brilliant Wizard Oil",		["item"]=OIL,		["bonusType"]=ITEM,		["bonusValue"]=32,	["skill"]=300,	["source"]=VENDOR,	["rod"]=RAR, ["content"]={[LBS]=2, [IV]=1, [4625]=3},	["bonusText"]="+36 d/h",	["itemLink"]="|cffffffff|Hitem:20749:0:0:0|h[Brilliant Wizard Oil]|h|r"};
EDB_Formula[25130] = {["name"]="Brilliant Mana Oil",		["item"]=OIL,		["bonusType"]=ITEM,		["bonusValue"]=12,	["skill"]=300,	["source"]=VENDOR,	["rod"]=RAR, ["content"]={[LBS]=2, [IV]=1, [8831]=3},	["bonusText"]="12 mp/5s",	["itemLink"]="|cffffffff|Hitem:20748:0:0:0|h[Brilliant Mana Oil]|h|r"};

-----[[ CREATE WAND ]]-----
EDB_Formula[14293] = {["name"]="Lesser Magic Wand",			["item"]=WAND,		["bonusType"]=ITEM,		["bonusValue"]=0,	["skill"]=10,  ["source"]=TRAINER,	["rod"]=RCR, ["content"]={[4470]=1, [LME]=1},			["bonusText"]="Wand",		["itemLink"]="|cff1eff00|Hitem:11287:0:0:0|h[Lesser Magic Wand]|h|r"};
EDB_Formula[14807] = {["name"]="Greater Magic Wand",		["item"]=WAND,		["bonusType"]=ITEM,		["bonusValue"]=1,	["skill"]=91,  ["source"]=TRAINER,	["rod"]=RCR, ["content"]={[4470]=1, [GME]=1},			["bonusText"]="Wand",		["itemLink"]="|cff1eff00|Hitem:11288:0:0:0|h[Greater Magic Wand]|h|r"};
EDB_Formula[14809] = {["name"]="Lesser Mystic Wand",		["item"]=WAND,		["bonusType"]=ITEM,		["bonusValue"]=2,	["skill"]=155, ["source"]=TRAINER,	["rod"]=RGR, ["content"]={[11291]=1, [LYE]=1, [SD]=1},	["bonusText"]="Wand",		["itemLink"]="|cff1eff00|Hitem:11289:0:0:0|h[Lesser Mystic Wand]|h|r"};
EDB_Formula[14810] = {["name"]="Greater Mystic Wand",		["item"]=WAND,		["bonusType"]=ITEM,		["bonusValue"]=3,	["skill"]=175, ["source"]=TRAINER,	["rod"]=RGR, ["content"]={[11291]=1, [GYE]=1, [VD]=1},	["bonusText"]="Wand",		["itemLink"]="|cff1eff00|Hitem:11290:0:0:0|h[Greater Mystic Wand]|h|r"};

-----[[ CREATE ROD ]]-----
EDB_Formula[7421]  = {["name"]="Runed Copper Rod",			["item"]=ROD,		["bonusType"]=ITEM,		["bonusValue"]=4,	["skill"]=0,   ["source"]=TRAINER,	["rod"]=0,	 ["content"]={[6217]=1, [TD]=1, [LME]=1},				["bonusText"]="Rod",	["itemLink"]="|cffffffff|Hitem:6218:0:0:0|h[Runed Copper Rod]|h|r"};
EDB_Formula[13628] = {["name"]="Runed Silver Rod",			["item"]=ROD,		["bonusType"]=ITEM,		["bonusValue"]=5,	["skill"]=100, ["source"]=TRAINER,	["rod"]=0,	 ["content"]={[6338]=1, [TD]=6, [GME]=3, [1210]=1},		["bonusText"]="Rod",	["itemLink"]="|cffffffff|Hitem:6339:0:0:0|h[Runed Silver Rod]|h|r"};
EDB_Formula[7795]  = {["name"]="Runed Golden Rod",			["item"]=ROD,		["bonusType"]=ITEM,		["bonusValue"]=6,	["skill"]=150, ["source"]=TRAINER,	["rod"]=0,	 ["content"]={[5500]=1, [11128]=1, [GAE]=2, [SD]=2},	["bonusText"]="Rod",	["itemLink"]="|cffffffff|Hitem:11130:0:0:0|h[Runed Golden Rod]|h|r"};
EDB_Formula[13702] = {["name"]="Runed Truesilver Rod",		["item"]=ROD,		["bonusType"]=ITEM,		["bonusValue"]=7,	["skill"]=200, ["source"]=TRAINER,	["rod"]=0,	 ["content"]={[11144]=1, [7971]=1, [GYE]=2, [VD]=2},	["bonusText"]="Rod",	["itemLink"]="|cffffffff|Hitem:11145:0:0:0|h[Runed Truesilver Rod]|h|r"};
EDB_Formula[20051] = {["name"]="Runed Arcanite Rod",		["item"]=ROD,		["bonusType"]=ITEM,		["bonusValue"]=8,	["skill"]=290, ["source"]=VENDOR,	["rod"]=0,	 ["content"]={[16206]=1, [13926]=1, [ID]=10, [GEE]=4, [SBS]=4, [LBS]=2},	["bonusText"]="Rod",	["itemLink"]="|cffffffff|Hitem:16207:0:0:0|h[Runed Arcanite Rod]|h|r"};

-----[[ MISC ]]-----
EDB_Formula[17180] = {["name"]="Enchanted Thorium",			["item"]=IOTHER,	["bonusType"]=ITEM,		["bonusValue"]=9,	["skill"]=250, ["source"]=TRAINER,	["rod"]=RTR, ["content"]={[12359]=1, [DD]=3},				["bonusText"]="",	["itemLink"]="|cffffffff|Hitem:12655:0:0:0|h[Enchanted Thorium Bar]|h|r"};
EDB_Formula[17181] = {["name"]="Enchanted Leather",			["item"]=IOTHER,	["bonusType"]=ITEM,		["bonusValue"]=10,	["skill"]=250, ["source"]=TRAINER,	["rod"]=RTR, ["content"]={[8170]=1, [LEE]=1},				["bonusText"]="",	["itemLink"]="|cffffffff|Hitem:12810:0:0:0|h[Enchanted Leather]|h|r"};
EDB_Formula[15596] = {["name"]="Smoking Heart of the Mountain",["item"]=IOTHER,	["bonusType"]=ITEM,		["bonusValue"]=11,	["skill"]=265, ["source"]=DROP,		["rod"]=6,	 ["content"]={[11382]=1, [7078]=1, [SBS]=3},	["bonusText"]="",	["itemLink"]="|cff0070dd|Hitem:11811:0:0:0|h[Smoking Heart of the Mountain]|h|r"};



-- Formula to set up missing bonusText attributes in EDB_Formula
function EDB_Formula_Setup()

	local ShortBonus = {"All", "Agi", "Int", "Spi", "Sta", "Str", "Dmg", "Res", "Stat", "Other"};

	for id, formula in EDB_Formula do

		-- autocreate missing bonus text
		if ( formula.bonusText == nil ) then

			formula.bonusText = "+"..formula.bonusValue.." "..ShortBonus[formula.bonusType];

		end

		-- Get an icon for it
		if ( formula.itemLink ) and ( formula.itemLink ~= "" ) then
			_, _, _, _, _, _, _, _, formula.icon = GetItemInfo(EDB_HItemFromLink(formula.itemLink));
		end

		if ( not formula.icon ) then
			formula.icon = "Interface\\Icons\\Spell_Holy_GreaterHeal";
		end

		-- sort the contents field by reagent number
--		local reagent = {};
--		local count = {};
--		local i;

--		for i in pairs(formula.content) do
--			table.insert(reagent, i);
--		end

--		table.sort(reagent);

--		for i in reagent do
--			count[i] = formula.content[reagent[i]];
--		end

--		formula.content = {};
--		formula.content.reagent = reagent;
--		formula.content.count   = count;

	end

end

function EDB_CSI_ReagentValue_Build()

	if ( not EDB_CSI ) then
		EDB_CSI = {};
	end
	
	if ( not EDB_CSI.reagentValue ) then
		EDB_CSI.reagentValue = {};
	end

	for id, link in EDB_Reagent do

		EDB_CSI.reagentValue[id] = EDB_GetValue(link) or EDB_CSI.reagentValue[id] or 0;
		EDB_CSI.reagentValue[id] = floor( EDB_CSI.reagentValue[id] + 0.5 );

	end

end

function EDB_ReagentIcon_Build()

	EDB_ReagentIcon = {};

	for id, link in EDB_Reagent do

		_, _, _, _, _, _, _, _, EDB_ReagentIcon[id] = GetItemInfo(id);
		if ( not EDB_ReagentIcon[id] ) then
			EDB_ReagentIcon[id] = "Interface\\Icons\\Spell_Holy_GreaterHeal";
		end

	end

end

function EDB_CSI_Formula_Build()

	local numCrafts = GetNumCrafts();

	if ( not EDB_CSI ) then
		EDB_CSI = {};
	end

	EDB_CSI.formula = {};

	local colors = {["trivial"] = 0, ["easy"] = 1, ["medium"] = 2, ["optimal"] = 3, ["difficult"] = 4};

	for id, formula in EDB_Formula do

		-- Search through craft list.
		for craftNum = 1, numCrafts do

			local link = GetCraftItemLink(craftNum);
			local _, _, difficulty = GetCraftInfo(craftNum);

			if ( id == EDB_HEnchantFromLink(link) ) then

				EDB_CSI.formula[id] = { };
				EDB_CSI.formula[id].difficulty = colors[difficulty];
				EDB_CSI.formula[id].craftNum = craftNum;

			end

		end

	end

end

function EDB_HEnchantFromLink(link)

	local henchant;

	if ( not link ) then
		return nil;
	end

	for henchant in string.gfind(link, "|c%x+|Henchant:(%d+)|h%[.-%]|h|r") do
		return tonumber(henchant);
	end

	return nil;

end

function EDB_Formula_GetEnchantLink(id)

	local name;

	if ( not EDB_Formula[id] ) then
		return "[Unknown Link]";
	end

	if ( EDB_Formula[id].typo ) then
		name = EDB_Formula[id].typo;
	elseif ( EDB_Formula[id].item <= 9) then
		name = "Enchant "..EDB_ItemTypeList[EDB_Formula[id].item].." - "..EDB_Formula[id].name;
	else
		name = EDB_Formula[id].name;
	end

	-- "|cffffffff|Henchant:%d|h[%s]|h|r"
	return "|cffffffff|Henchant:"..id.."|h["..name.."]|h|r";

end

function EDB_Reagent_Find(name)

	for id in EDB_Reagent do

		local rname;

		for thing in string.gfind(EDB_Reagent[id], "|c%x+|Hitem:%d+:%d+:%d+:%d+|h%[(.-)%]|h|r") do
			rname = thing;
		end

		if ( name == rname ) then

			return id;

		end

	end

end

