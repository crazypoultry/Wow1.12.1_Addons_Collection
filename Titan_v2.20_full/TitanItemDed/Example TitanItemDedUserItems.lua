
-- This line will set Autodrop to ON on every load, instead of the default OFF
TPID_UseAutodrop = true

-- Anything in this list will override ignore set options
-- index == itemID
-- Ex: You want to ignore all leather EXCEPT Ruined Scraps
TitanItemDed_OverrideItems = {
	[2934] = true,	-- Ruined Scraps
};

-- Anything in this list will override the vendor price
-- index == itemID, value == price to use
-- Auctioneer prices will override these prices however
TitanItemDed_OverridePrices = {
	[2318] = 100,			-- Light Leather
	[2319] = 360,			-- Medium Leather
	[4234] = 500,			-- Heavy Leather
	[4304] = 500,			-- Thick Leather
	[8170] = 500,			-- Rugged Leather

--	[783] = 275,			-- Light Hide
	[4232] = 400,			-- Medium Hide
	[8169] = 400,			-- Thick Hide
	[8171] = 400,			-- Rugged Hide

	[2589] = 130,			-- Linen Cloth
	[2592] = 800,			-- Wool Cloth
	[4306] = 800,			-- Silk Cloth
	[4338] = 800,			-- Mageweave Cloth
	[14047] = 800,		-- Runecloth
	[14256] = 800,		-- Felcloth

	[2447] = 30,			-- Peacebloom
	[765] = 110,			-- Silverleaf
	[2449] = 530,			-- Earthroot
	[2450] = 830,			-- Briarthorn
	[2452] = 2375,		-- Swiftthistle
	[785] = 225,			-- Mageroyal
	[2453] = 600,			-- Bruiseweed

	[10940] = 640,		-- Strange Dust
	[11083] = 2400,		-- Soul Dust
	[11137] = 2400,		-- Vision Dust
	[11137] = 2400,		-- Dream Dust
	[16204] = 2400,		-- Illusion Dust

	[10938] = 1687,		-- L Magic Essence
	[10939] = 5063,		-- G Magic Essence
	[10998] = 12000,	-- L Astral Essence
	[11082] = 36000,	-- G Astral Essence
	[11134] = 2462,		-- L Mystic Essence
	[11135] = 7388,		-- G Mystic Essence
	[11174] = 7388,		-- L Nether Essence
	[11175] = 7388,		-- G Nether Essence
	[16202] = 7388,		-- L Eternal Essence
	[16203] = 7388,		-- G Eternal Essence

	[10978] = 7388,		-- S Glimmering Shard
	[11084] = 7388,		-- L Glimmering Shard
	[11138] = 7388,		-- S Glowing Shard
	[11139] = 7388,		-- L Glowing Shard
	[11177] = 7388,		-- S Radiant Shard
	[11178] = 7388,		-- L Radiant Shard
	[14343] = 7388,		-- S Brilliant Shard
	[14344] = 7388,		-- L Brilliant Shard
};
