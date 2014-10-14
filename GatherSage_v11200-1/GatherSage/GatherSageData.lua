-- File in which we build the data structures

gsMine = {
	[gsCopper] = { ["baseskill"]=1 },
	[gsTin] = { ["baseskill"]=65 },
	[gsSilver] = { ["baseskill"]=75 },
	[gsIron] = { ["baseskill"]=125 },
	[gsGold] = { ["baseskill"]=155 },
	[gsMithril] = { ["baseskill"]=175 },
	[gsTruesilver] = { ["baseskill"]=230 },
	[gsSmallThorium] = { ["baseskill"]=245 },
	[gsRichThorium] = { ["baseskill"]=275 },
	[gsDarkIron] = { ["baseskill"]=230 },
	[gsIncendicite] = { ["baseskill"]=65 },
	[gsLesserBloodstone] = { ["baseskill"]=155 },
	[gsIndurium] = { ["baseskill"]=150 },
	[gsObsidianChunk] = { ["baseskill"]=305 },
};

gsGem = {
	[gsTigerseye] = gsCopper.."/"..gsTin,
};

gsStone = {
	[gsRoughStone] = gsCopper,
	[gsCoarseStone] = gsTin,
	[gsHeavy] = gsIron,
	[gsSolid] = gsMithril,
	[gsDense] = gsThorium,
};

gsMineHasStone = {
	[gsCopper] = gsRoughStone,
	[gsTin] = gsCoarseStone,
	[gsIron] = gsHeavy,
	[gsMithril] = gsSolid,
	[gsSmallThorium] = gsDense,
	[gsRichThorium] = gsDense,
};

gsHerbHasHerb = {
	[gsMageroyal] = gsSwiftThistle,
	[gsBriarthorn] = gsSwiftThistle,
	[gsPurpleLotus] = gsWildvine,
};

gsHerb = {
	[gsPeacebloom] = { ["baseskill"]=1 },
	[gsSilverleaf] = { ["baseskill"]=1 },
	[gsEarthroot] = { ["baseskill"]=15 },
	[gsMageroyal] = { ["baseskill"]=50 },
	[gsBriarthorn] = { ["baseskill"]=70 },
	[gsStranglekelp] = { ["baseskill"]=85 },
	[gsBruiseweed] = { ["baseskill"]=100 },
	[gsWildSteelbloom] = { ["baseskill"]=115 },
	[gsGraveMoss] = { ["baseskill"]=120 },
	[gsKingsblood] = { ["baseskill"]=125 },
	[gsLiferoot] = { ["baseskill"]=150 },
	[gsFadeleaf] = { ["baseskill"]=160 },
	[gsGoldthorn] = { ["baseskill"]=170 },
	[gsKhadgar] = { ["baseskill"]=185 },
	[gsWintersbite] = { ["baseskill"]=195 },
	[gsFirebloom] = { ["baseskill"]=205 },
	[gsPurpleLotus] = { ["baseskill"]=210 },
	[gsArthas] = { ["baseskill"]=220 },
	[gsSungrass] = { ["baseskill"]=230 },
	[gsBlindweed] = { ["baseskill"]=235 },
	[gsGhostMushroom] = { ["baseskill"]=245 },
	[gsGromsblood] = { ["baseskill"]=250 },
	[gsGoldenSansam] = { ["baseskill"]=260 },
	[gsDreamfoil] = { ["baseskill"]=270 },
	[gsMountainSilversage] = { ["baseskill"]=280 },
	[gsPlaguebloom] = { ["baseskill"]=285 },
	[gsIcecap] = { ["baseskill"]=290 },
	[gsBlackLotus] = { ["baseskill"]=300 },
};
