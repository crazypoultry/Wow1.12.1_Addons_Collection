
ALPHA_MAP_VERSION 		= "2.62.11200";

-- Constant used to Register AlphaMap with MapNotes to allow note creation on Instance/BG/World Boss Maps
AM_MN_PLUGIN = 	{	name	= "AlphaMap",
			frame	= "AlphaMapAlphaMapFrame",
			keyVal	= "AlphaMap_MN_Query",
			lclFnc	= "AlphaMap_MN_Localiser",
		};

-- Constants used in Instance data that don't require localisation
-- (Note : these can be overidden in any localisation file if required)

AM_EXIT_SYMBOL			= "X";
AM_ENTRANCE_SYMBOL		= "X";
AM_CHEST_SYMBOL			= "C";
AM_STAIRS_SYMBOL		= "S";
AM_ROUTE_SYMBOL			= "R";
AM_QUEST_SYMBOL			= "Q";
AM_DFLT_SYMBOL			= "X";
AM_ABBREVIATED			= "..";
AM_BLANK_KEY_SYMBOL		= " ";
				-----@@RRGGBB-----
AM_RED				= "|c00FF1010";		-- default used for hostile mobs, and Exits
AM_GREEN			= "|c0000FF00";		-- default used for neutral/friendly NPCs
AM_BLUE				= "|c005070FF";		-- default used for Entrances, and Stairs/Paths between distinct map areas
AM_GOLD				= "|c00FFD200";		-- default used for Chests
AM_PURPLE			= "|c00FF35A3";
AM_ORANGE			= "|c00FF7945";		-- default used for Quest items/objects
AM_DFLT_COLOUR			= AM_GOLD;
AM_YELLOW			= "|c00FFFF00";
AM_NUN				= "NotesUNeed";

AM_AL				= "AtlasLoot Enhanced";

-- Minimap texture data for World Boss Maps
AM_Minimap_Data = {
	AM_Kazzak_Map 	= 		{	{	{ 	filename = "b5495897bd4833751deb27a2ed22c894",
								height = 256,
								width = 256,
								texcoordinates = { 0.3, 1, 0.75, 1 }
							},
							{	filename = "cf584aea412c82e4b42cc5424a1d1da5",
								height = 256,
								width = 256,
								texcoordinates = { 0.3, 1, 0, 1 }
							},
							{	filename = "f9ef3e6c36c89e0d1c0e2e035322420e",
								height = 256,
								width = 256,
								texcoordinates = { 0.3, 1, 0, 0.16 }
							}
						},
						{	{ 	filename = "58bae9872bf403ffe17b271360eb3fda",
								height = 256,
								width = 256,
								texcoordinates = { 0, 0.45, 0.75, 1 }
							},
							{	filename = "8097163e3663802e3fbc03dec9d9ff90",
								height = 256,
								width = 256,
								texcoordinates = { 0, 0.45, 0, 1 }
							},
							{	filename = "8b271eeb6cf449f770a053c495c7dcbe",
								height = 256,
								width = 256,
								texcoordinates = { 0, 0.45, 0, 0.16 }
							}
						}
					},

	AM_Azuregos_Map = 		{	{	{ 	filename = "e47f0e926018e5f7b45a9cddb4386f18",
								height = 256,
								width = 256,
								texcoordinates = { 0.8, 1, 0.5, 1 }
							},
							{	filename = "cc1864426c39fe08c6a3e53f2499b25c",
								height = 256,
								width = 256,
								texcoordinates = { 0.8, 1, 0, 0.8 }
							}
						},
						{	{ 	filename = "24b333c35a7192b5ed2198ae40437955",
								height = 256,
								width = 256,
								texcoordinates = { 0, 1, 0.5, 1 }
							},
							{	filename = "58c81a2657f9d594fbf6188bcda85599",
								height = 256,
								width = 256,
								texcoordinates = { 0, 1, 0, 0.8 }
							}
						},
						{	{ 	filename = "484392bce9171bf299e35148898cebf9",
								height = 256,
								width = 256,
								texcoordinates = { 0, 0.1, 0.5, 1 }
							},
							{	filename = "99b38dce4a54a753e6147b38702731e1",
								height = 256,
								width = 256,
								texcoordinates = { 0, 0.1, 0, 0.8 }
							}
						}
					},

	AM_Dragon_Duskwood_Map = 	{	{	{	filename = "c69d18b0703f40117eb5b3772aedb8d6",
								height = 256,
								width = 256,
								texcoordinates = { 0.4, 1, 0.1, 1 }
							},
							{	filename = "01977102194646854a915529cf32679a",
								height = 256,
								width = 256,
								texcoordinates = { 0.4, 1, 0, 0.05 }
							}
						    },
						    {	{	filename = "5eb877c2be769bd35f29e4b5d50d6541",
								height = 256,
								width = 256,
								texcoordinates = { 0, 0.25, 0.1, 1 }
							},
							{	filename = "c141a3e6056cc2264fbeac47d0138270",
								height = 256,
								width = 256,
								texcoordinates = { 0, 0.25, 0, 0.05 }
							}
				    		    }
				  	},

	AM_Dragon_Hinterlands_Map = 	{	{	{	filename = "4f118530542beebc4d9869a6c5eb0508",
								height = 256,
								width = 256,
								texcoordinates = { 0, 1, 0, 1 }
							},
						}
				  	},

	AM_Dragon_Feralas_Map = 	{	{	{	filename = "3d41a61fa80e1dd7532afc4cba2433d5",
								height = 256,
								width = 256,
								texcoordinates = { 0, 1, 0.83, 1 }
							},
							{	filename = "b476f2a74354c7be076b0c01a0408db4",
								height = 256,
								width = 256,
								texcoordinates = { 0, 1, 0, 0.83 }
							}
						    }
					},

	AM_Dragon_Ashenvale_Map = 	{	{	{	filename = "7d01822fe4ee4d5ea12075707417325a",
								height = 256,
								width = 256,
								texcoordinates = { 0.5, 1, 0.33, 1 }
							},
							{	filename = "b64ee84896289bf8b149cbec350e14f1",
								height = 256,
								width = 256,
								texcoordinates = { 0.5, 1, 0, 0.33 }
							}
						    },
						    {	{	filename = "7a3a571e712aedc556ee56e0f23c60af",
								height = 256,
								width = 256,
								texcoordinates = { 0, 0.5, 0.33, 1 }
							},
							{	filename = "401c0a91ecd5117b5010c0f035f8cbd6",
								height = 256,
								width = 256,
								texcoordinates = { 0, 0.5, 0, 0.33 }
							}
						    }
					}

};