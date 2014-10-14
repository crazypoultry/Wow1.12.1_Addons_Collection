------------------------------------------------------------------------------------------------------
-- Arcanum

-- Addon pour Mage inspiré du célébre Necrosis
-- Gestion des buffs, des portails et Compteur de Composants

-- Remerciements aux auteurs de Necrosis

-- Auteur Lenny415

-- Serveur:
-- Uliss, Nausicaa, Solcarlus, Thémys on Medivh EU
------------------------------------------------------------------------------------------------------

function Arcanum_Localization_Dialog_En()
	function ArcanumLocalization()
		Arcanum_Localization_Speech_En();
	end
	-- Raccourcis claviers
	BINDING_HEADER_ARCANUM_BIND = "Arcanum";   
	BINDING_NAME_STEED = "Steed";
	BINDING_NAME_FROSTARMOR = "Ice Armor";
	BINDING_NAME_MAGEARMOR = "Mage Armor";
	BINDING_NAME_ARCANEINTELLECT = "Arcane Intellect";
	BINDING_NAME_ARCANEBRILLIANCE = "Arcane Brilliance";
	BINDING_NAME_AMPLIFYMAGIC = "Amplify Magic";
	BINDING_NAME_DAMPENMAGIC = "Dampen Magic";
	BINDING_NAME_CONJUREFOOD = "Conjure Food";
	BINDING_NAME_USEFOODWATER = "Eating & Drinking";
	BINDING_NAME_USEFOOD = "Eating";
	BINDING_NAME_CONJUREWATER = "Conjure Water";
	BINDING_NAME_USEWATER = "Drinking";
	BINDING_NAME_CONJUREMANAGEM = "Conjure a mana Gem";
	BINDING_NAME_USEMANAGEM = "Using a mana gem";
	BINDING_NAME_EVOCATION = "Evocation";
	BINDING_NAME_TELEPORT1 = "Teleport 1";
	BINDING_NAME_TELEPORT2 = "Teleport 2";
	BINDING_NAME_TELEPORT3 = "Teleport 3";
	BINDING_NAME_PORTAL1 = "Portal 1";
	BINDING_NAME_PORTAL2 = "Portal 2";
	BINDING_NAME_PORTAL3 = "Portal 3";
	
	ARCANUM_CONFIGURATION = {
		["Menu1"] = "Messages",
		["MessageMenu1"] = "Player :",
		["Tooltip0"] = "No Tooltip",
		["Tooltip1"] = "Partial Tooltips",
		["Tooltip2"] = "Full Tooltips",
		["ChatType"] = "Messages = System messages",
		["PortalMessage"] = "Show messages when summoning a portal",
        ["ArcanumButtonDisplay"] = "Display inside the sphere :",
        ["InsideDisplay"] = "Display inside the sphere:",
        ["DisplayHearthStone"] = "HearthStone",
        ["DisplayManaGem"] = "ManaGem",
        ["DisplayEvocation"] = "Evocation",
        ["DisplayIceBlock"] = "IceBlock",
        ["DisplayColdSnap"] = "ColdSnap",
        ["DisplayIntell"] = "Intell.",
        ["DisplayArmor"] = "Armor",
        ["DisplayBandage"] = "Bandage",
        ["HealthColor"] = "Health bar color",
        ["ManaColor"] = "Mana bar color",
        ["ButtonColor"] = "Mouseover buttons color",
				
		["Menu2"] = "Misc.",
		["LevelBuff"] = "Buff the target depending on his level",
		["EvocationLimit"] = "Mana percentage Evocation can be casted",
        ["ConsumeLeftFood"] = "Consume Water/Food starting by the left bag",
        ["ConsumeRightFood"] = "Consume Water/Food starting by the right bag",
        ["RandMount"] = "Summon a mount randomly",
        ["DeleteFood"] = "Delete conjured food",
		["DeleteWater"] = "Delete conjured water",
		["DeleteManaGem"] = "Delete conjured mana gems",
		
		["Menu3"] = "Reagent Auto buy",
		["ReagentSort"] = "Sort reagents in same bag",
		["ReagentBag"] = "Reagent bag",
		["ReagentBuy"] = "Auto buy reagents",
		["Reagent"] = "Reagent Maximum quantity in bags:",
		["Powder"] = "Arcane Powder",
		["Teleport"] = "Rune of Teleportation",
		["Portal"] = "Rune of Portals",
		
		["Menu4"] = "Graphical Settings",
		["Toggle"] = "Activate Arcanum",
        ["InterfaceVersion"] = "Arcanum with menus",
		["InterfaceVersion2"] = "Arcanum without menus",
		["Lock"] = "Lock Arcanum",
		["IconsLock"] = "Lock Arcanum Buttons",
		["MenuPosition"] = "Menu Opening ways:",
		["BuffMenu"] = "Buffs: top/bottom wether checked, right/left or not",
		["ArmorMenu"] = "Armors: top/bottom wether checked, right/left or not",
		["MagicMenu"] = "Magic: top/bottom wether checked, right/left or not",
		["PortalMenu"] = "Portals: top/bottom wether checked, right/left or not",
        ["MountMenu"] = "Mounts: top/bottom wether checked, right/left or not",
		["ArcanumRotation"] = "Rotate Arcanum",
		["ArcanumSize"] = "Size of Arcanum",
		
		["Menu5"] = "Buttons",
        ["Button"] = "Show button of:",
        ["Order"] = "Change buttons order:",
		["BuffButton"] = "buffs",
		["ArmorButton"] = "armors",
		["MagicButton"] = "magic",
		["PortalButton"] = "portals",
		["MountButton"] = "mount",
		["FoodButton"] = "food",
		["WaterButton"] = "water",
		["ManaGemButton"] = "mana gem",
        ["MinimapIcon"] = "Show minimap icon",
        ["ArcanumMinimapIconPos"] = "Minimap icon position:",
	};
	
    ARCANUM_CLICK = {
        [1] = "Evocation";
        [2] = "Eating & Drinking";
        [3] = "Switch solo/groupe mode";
        [4] = "Configuration panel";
        [5] = "Mana gems";
        [6] = "Ice block";
        [7] = "Trade";
        [8] = "Hearthstone";
    };
    
    ARCANUM_INSIDE_DISPLAY = {
        "Health",
        "Mana",
        "Nothing",
    };
    
	-- Traduction
	ARCANUM_TRANSLATION = {
		["Mounting"] = "Summoning",
        ["Hearth"] = "Hearthstone";
		["Cooldown"] = "Cooldown",
		["Rank"] = "Rank",
	};

	ARCANUM_TOOLTIP_DATA = {
	["LastSpell"] = "Left click to cast",
        ["SpellTimer"] = {
			Label = "Spell Durations",
			Text = "Active Spells on the target",
			Right = "<white>Right Click for Hearthstone to "
        };
	};
	
	-- Message
	ARCANUM_MESSAGE = {
	  	["Interface"] = {
	    	["InitOn"] = "<white>activated. /arcanum or /arca to show the Configuration window",
	    	["InitOff"] = "<white>deactivated. /arca",
			["DefaultConfig"] = "<lightYellow>Default configuration loaded.",
			["UserConfig"] = "<lightYellow>Configuration loaded."
		},
	  	["Tooltip"] = {
	   		["LeftClick"] = "Left Click: ",
			["MiddleClick"] = "Middle Click: ",
	    	["RightClick"] = "Right Click: ",
	 		["Cooldown"] = "Hearthstone available in ",
            ["Minimap"] = "Configuration panel",
	  	},
		["Error"] = {
	  		["NoHearthstone"] = "No Hearthstone has been found in inventory.",
      		["NoMount"] = "No mount has been found in inventory.",
		},
		["Autobuy"] = "Buying ",
	};
end

function Arcanum_Localization_Speech_En()
	ARCANUM_PORTAL_MESSAGES = {
		[1] = {
			"The <me> Airline Company wishes you an enjoyable trip to <city>" 
		},
		[2] = {
			"Please click <me>'s portal and you will arrive at <city>"
		},
		[3] = {
			"Don't interrupt <me> now because <me2> is busy opening a portal to <city>"
		},
		[4] = {
			"<city> is opening in 10 seconds, have a nice journey"
		},
	};
end

if ( GetLocale() == "enUS" ) or ( GetLocale() == "enGB" ) then
	-- Table des sorts du mage
	ARCANUM_SPELL_TABLE = {
		["ID"] = {},
		["Rank"] = {},
		["Name"] = {
			"Frost Armor",										--1
			"Ice Armor",                      					--2
			"Mage Armor",                   					--3
			"Arcane Intellect",			                		--4
			"Arcane Brilliance",	                        	--5
            "Dampen Magic",                  					--6
			"Amplify Magic",                        			--7
			"Conjure Food",                       				--8
			"Conjure Water",                        			--9
			"Conjure Mana Agate",       						--10
			"Conjure Mana Jade",                   			 	--11		
			"Conjure Mana Citrine",                 			--12
			"Conjure Mana Ruby",				    			--13
			"Teleport: Darnassus",								--14
			"Teleport: Ironforge",								--15
			"Teleport: Stormwind",         						--16
			"Teleport: Orgrimmar",								--17
			"Teleport: Thunder Bluff",							--18
			"Teleport: Undercity",         						--19
			"Portal: Darnassus",								--20
			"Portal: Ironforge",					 			--21
			"Portal: Stormwind",								--22
			"Portal: Orgrimmar",								--23
			"Portal: Thunder Bluff",					 		--24
			"Portal: Undercity",	           					--25
			"Evocation",            							--26
            "Fire Ward",                                        --27
            "Frost Ward",                                       --28
            "Polymorph",                                        --29
            "Polymorph : Pig",                                  --30
            "Polymorph : Turtle",                               --31
            "Ice Block",                                        --32
            "Cold Snap",                                        --33
            "Premiers soins",                                   --34
			},
		["Mana"] = {},
        ["Texture"] = {},
	};
    
	ARCANUM_MANAGEM = {"Mana Agate", "Mana Jade", "Mana Citrine", "Mana Ruby"};
	
	ARCANUM_FOOD = {"Conjured Muffin", "Conjured Bread", "Conjured Rye", "Conjured Pumpernickel",
	"Conjured Sourdough", "Conjured Sweet Roll", "Conjured Cinnamon Roll"};
	
	ARCANUM_WATER = {"Conjured Water", "Conjured Fresh Water", "Conjured Purified Water",
	"Conjured Spring Water", "Conjured Mineral Water", "Conjured Sparkling Water", "Conjured Crystal Water"};
	
    ARCANUM_BANDAGE = "Un bandage a été appliqué récemment";
    
	-- Table des items du Mage
	ARCANUM_ITEM = {
		["ArcanePowder"] = "Arcane Powder",
		["RuneOfTeleportation"] = "Rune of Teleportation",
		["RuneOfPortals"] = "Rune of Portals",
		["LightFeathers"] = "Light Feather",
		["Hearthstone"] = "Hearthstone",
		["QuirajiMount"] = "Quiraji Resonating Crystal",
	};

	-- Monture	
	MOUNT = {{"Horn of the Black War Wolf", "Horn of the Brown Wolf", "Horn of the Red Wolf", "Horn of the Swift Brown Wolf", "Horn of the Timber Wolf"},
		{"Reins of the Striped Nightsaber", "Reins of the Black War Tiger"},
		{"Swift Zulian Tiger"},
		{"Gray Kodo", "Great Gray Kodo", "Great White Kodo"},
		{"Green Kodo", "Teal Kodo"},
		{"Black War Kodo", "Brown Kodo", "Great Brown Kodo"},
		{"Black Battlestrider", "Blue Mechanostrider", "Green Mechanostrider", "Icy Blue Mechanostrider Mod A", "Red Mechanostrider", "Swift Green Mechanostrider", "Swift White Mechanostrider", "Swift Yellow Mechanostrider", "Unpainted Mechanostrider", "White Mechanostrider Mod A"},
		{"Stormpike Battle Charger", "Black Ram", "Black War Ram", "Brown Ram", "Frost Ram", "Gray Ram", "Swift Brown Ram", "Swift Gray Ram", "Swift White Ram", "White Ram"},
		{"Black War Steed Bridle"},
		{"Reins of the Winterspring Frostsaber"},
		{"Whistle of the Black War Raptor", "Whistle of the Emerald Raptor", "Whistle of the Ivory Raptor", "Whistle of the Mottled Red Raptor", "Whistle of the Turquoise Raptor", "Whistle of the Violet Raptor", "Swift Olive Raptor", "Swift Orange Raptor", "Swift Blue Raptor", "Swift Razzashi Raptor"},
		{"Black Stallion Bridle", "Brown Horse Bridle", "Chestnut Mare Bridle", "Palomino Bridle", "Pinto Bridle", "Swift Brown Steed", "Swift Palomino", "Swift White Steed", "White Stallion Bridle"},
		{"Deathcharger's Reins", "Blue Skeletal Horse", "Brown Skeletal Horse", "Green Skeletal Warhorse", "Purple Skeletal Warhorse", "Red Skeletal Horse", "Red Skeletal Warhorse"},
		{"Horn of the Arctic Wolf", "Horn of the Dire Wolf", "Horn of the Swift Gray Wolf", "Horn of the Swift Timber Wolf"},
		{"Reins of the Frostsaber", "Reins of the Nightsaber", "Reins of the Spotted Frostsaber", "Reins of the Striped Frostsaber", "Reins of the Swift Frostsaber", "Reins of the Swift Mistsaber", "Reins of the Swift Stormsaber"},
		{"Horn of the Frostwolf Howler"},
	};
    
    MOUNT_SPEED = "Increases speed by (%d+)%%.";

	MOUNT_PREFIX = {"Reins of ", "Whistle of ", "Horn of ", " Bridle"};
		
	QIRAJ_MOUNT = {
		"Yellow Qiraji Resonating Crystal",
		"Red Qiraji Resonating Crystal",
	  	"Green Qiraji Resonating Crystal",
		"Blue Qiraji Resonating Crystal",
		"Black Qiraji Resonating Crystal",
	};

end