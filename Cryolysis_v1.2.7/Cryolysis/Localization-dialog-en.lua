------------------------------------------------------------------------------------------------------
-- Cryolysis
--
-- Based on Necrosis LdC by Lomig and Nyx (http://necrosis.larmes-cenarius.net)
-- Original Necrosis Idea : Infernal (http://www.revolvus.com/games/interface/necrosis/)
-- Cryolysis Maintainer : Kaeldra of Aegwynn
--
-- Contact : darklyte@gmail.com
-- Send me in-game mail!  Yersinia on Aegwynn, Horde side.
-- Guild: <Working as Intended>
-- Version Date: 07.14.2006
------------------------------------------------------------------------------------------------------


------------------------------------------------
-- ENGLISH  VERSION TEXTS --
------------------------------------------------

function Cryolysis_Localization_Dialog_En()

	function CryolysisLocalization()
		Cryolysis_Localization_Speech_En();
	end

	CRYOLYSIS_COOLDOWN = {
		["Evocation"] = "Evocation Cooldown",
		["Manastone"] = "Mana Gem Cooldown"
	};

	CryolysisTooltipData = {
		["Main"] = {
			Label = "|c00FFFFFFCryolysis|r",
			Stone = {
				[true] = "Yes";
				[false] = "No";
			},
			Hellspawn = {
				[true] = "On";
				[false] = "Off";
			},
			["Food"] = "Conjured Food: ",
			["Drink"] = "Conjured Drink: ",
			["RuneOfTeleportation"] = "Teleport Runes: ",
			["RuneOfPortals"] = "Portal Runes: ",
			["ArcanePowder"] = "Arcane Powder: ",
			["LightFeather"] = "Light Feathers: ",
			["Manastone"] = "Mana Gem: ",
  		},
		["Alt"] = {
			Left = "Right-click for ",
			Right = "",
		},
		["Soulstone"] = {
			Label = "|c00FF99FFSoulstone|r",
			Text = {"Create","Use","Used","Waiting"}			
		},
		["Manastone"] = {
			Label = "|c00FFFFFFMana Gem|r",
			Text = {": Conjure - ",": Restore ", ": Queued", ": Unavailable"}
		},
		["SpellTimer"] = {
			Label = "|c00FFFFFFSpell Durations|r",
			Text = "Cooldowns and Active Spells on the target",
			Right = "Right Click for Hearthstone to "
		},
		["Armor"] = {
			Label = "|c00FFFFFFIce Armor|r"
		},
		["MageArmor"] = {
			Label = "|c00FFFFFFMage Armor|r"
		},
		["ArcaneInt"] = {
			Label = "|c00FFFFFFArcane Intellect|r"
		},
		["ArcaneBrilliance"] = {
			Label = "|c00FFFFFFArcane Brilliance|r"
		},
		["DampenMagic"] = {
			Label = "|c00FFFFFFDampen Magic|r"
		},
		["AmplifyMagic"] = {
			Label = "|c00FFFFFFAmplify Magic|r"
		},
		["SlowFall"] = {
			Label = "|c00FFFFFFSlow Fall|r"
		},
		["FireWard"] = {
			Label = "|c00FFFFFFFire Ward|r"
		},
		["FrostWard"] = {
			Label = "|c00FFFFFFFrost Ward|r"
		},
		["ConjureFood"] = {
			Label = "|c00FFFFFFConjure Food|r"
		},
		["ConjureDrink"] = {
			Label = "|c00FFFFFFConjure Water|r"
		},
		["Evocation"] = {
			Label = "|c00FFFFFFEvocation|r",
			Text = "Use"
		},
		["ColdSnap"] = {
			Label = "|c00FFFFFFCold Snap|r"
		},
		["IceBarrier"] = {
			Label = "|c00FFFFFF"..CRYOLYSIS_SPELL_TABLE[23].Name.."|r"
		},
		["ManaShield"] = {
			Label = "|c00FFFFFF"..CRYOLYSIS_SPELL_TABLE[25].Name.."|r"
		},
		["DetectMagic"] = {
			Label = "|c00FFFFFFDetect Magic|r"
		},
		["RemoveCurse"] = {
			Label = "|c00FFFFFFRemove Lesser Curse|r"
		},
		["Mount"] = {
			Label = "|c00FFFFFFSteed: "
		},
		["Buff"] = {
			Label = "|c00FFFFFFSpell Menu|r\nMiddle-click to keep the menu open"
		},
		["Portal"] = {
			Label = "|c00FFFFFFPortals Menu|r\nMiddle click to keep the menu open"
		},
		["T:Org"] = {
		    Label = "|c00FFFFFFTeleport: Orgrimmar|r"
		},
		["T:UC"] = {
		    Label = "|c00FFFFFFTeleport: Undercity|r"
		},
		["T:TB"] = {
		    Label = "|c00FFFFFFTeleport: Thunder Bluff|r"
		},
		["T:IF"] = {
		    Label = "|c00FFFFFFTeleport: Ironforge|r"
		},
		["T:SW"] = {
		    Label = "|c00FFFFFFTeleport: Stormwind|r"
		},
		["T:Darn"] = {
		    Label = "|c00FFFFFFTeleport: Darnassus|r"
		},
		["P:Org"] = {
		    Label = "|c00FFFFFFPortal: Orgrimmar|r"
		},
		["P:UC"] = {
		    Label = "|c00FFFFFFPortal: Undercity|r"
		},
		["P:TB"] = {
		    Label = "|c00FFFFFFPortal: Thunder Bluff|r"
		},
		["P:IF"] = {
		    Label = "|c00FFFFFFPortal: Ironforge|r"
		},
		["P:SW"] = {
		    Label = "|c00FFFFFFPortal: Stormwind|r"
		},
		["P:Darn"] = {
		    Label = "|c00FFFFFFPortal: Darnassus|r"
		},
		["EvocationCooldown"] = "Right click for fast summon",
		["LastSpell"] = {
			Left = "Right-click to recast ",      -- <--
			Right = "",
		},
		["Food"] = {
			Label = "|c00FFFFFFFood|r",
			Right = "Right-click to conjure",
			Middle = "Middle-click to trade",
		},
		["Drink"] = {
			Label = "|c00FFFFFFDrink|r",
			Right = "Right-click to conjure ",
			Middle = "Middle-click to trade",
		},
	};


	CRYOLYSIS_SOUND = {
		["SheepWarn"] = "Interface\\AddOns\\Cryolysis\\sounds\\Sheep01.mp3",
		["SheepBreak"] = "Interface\\AddOns\\Cryolysis\\sounds\\Sheep02.mp3",
		["PigWarn"] = "Interface\\AddOns\\Cryolysis\\sounds\\Pig01.mp3",
		["PigBreak"] = "Interface\\AddOns\\Cryolysis\\sounds\\Pig02.mp3",
	};


--	CRYOLYSIS_NIGHTFALL_TEXT = {
--		["NoBoltSpell"] = "You do not seem to have any Shadow Bolt Spell.",
--		["Message"] = "<white>S<lightPurple1>h<lightPurple2>a<purple>d<darkPurple1>o<darkPurple2>w T<darkPurple1>r<purple>a<lightPurple2>n<lightPurple1>c<white>e"
--	};


	CRYOLYSIS_MESSAGE = {
		["Error"] = {
			["RuneOfTeleportationNotPresent"] = "You need a Rune of Teleportation to do that!",
			["RuneOfPortals"] = "You need a Rune of Portals to do that !",
			["LightFeatherNotPresent"] = "You need a Light Feather to do that !",
			["ArcanePowderNotPresent"] = "You need Arcane Powder to do that !",
			["NoRiding"] = "You do not have any Steed to ride !",
			["NoFoodSpell"] = "You do not have any Food creation spell",
			["NoDrinkSpell"] = "You do not have any Drink creation spell",
			["NoManaStoneSpell"] = "You do not have any Mana Gem creation spell",
			["NoEvocationSpell"] = "You do not have any Evocation spell",
			["FullMana"] = "You cannot use your Mana Gem since you have full MP",
			["BagAlreadySelect"] = "Error : This bag is already selected.",
			["WrongBag"] = "Error: The number must be between 0 and 4.",
			["BagIsNumber"] = "Error: Please type a number.",
			["NoHearthStone"] = "Error: You do not have a Hearthstone in your inventory",
			["NoFood"] = "Error: You do not have any Conjured Food of the highest rank in your inventory",
			["NoDrink"] = "Error: You do not have any Conjured Drink of the highest rank in your inventory",
			["ManaStoneCooldown"] = "Error: Mana gem currently on cooldown",
			["NoSpell"] = "Error: You do not know that spell",
		},
		["Bag"] = {
			["FullPrefix"] = "Your ",
			["FullSuffix"] = " is full !",
			["FullDestroySuffix"] = " is full; Next food/drink will be destroyed !",
			["SelectedPrefix"] = "You have chosen your ",
			["SelectedSuffix"] = " to keep your food and drink."
		},
		["Interface"] = {
			["Welcome"] = "<white>/cryo to show the setting menu!",
			["TooltipOn"] = "Tooltips turned on" ,
			["TooltipOff"] = "Tooltips turned off",
			["MessageOn"] = "Chat messaging turned on",
			["MessageOff"] = "Chat messaging turned off",
			["MessagePosition"] = "<- System messages by Cryolysis will appear here ->",
			["DefaultConfig"] = "<lightYellow>Default configuration loaded.",
			["UserConfig"] = "<lightYellow>Configuration loaded."
		},
		["Help"] = {
			"/cryo recall -- Center Cryolysis and all buttons in the middle of the screen",
			"/cryo sm -- Replace messages with a short raid-ready version",
			"/cryo decurse -- cast Remove Lesser curse using decursive feature",
			"/cryo poly -- randomly cast between available polymorph spells",
			"/cryo coldblock -- Activate Iceblock or Cold Snap",
			"/cryo reset -- Restore and reload default Cryolysis configurations",
			"/serenity toggle -- hide/show the main serenity sphere",
			"change the spell buttons by adjusting the sliders in the button menu",			
		},
		["EquipMessage"] = "Equip ",
		["SwitchMessage"] = " instead of ",
		["Information"] = {
			["PolyWarn"] = "Polymorph is about to break",
			["PolyBreak"] = "Polymorph has broken...",
			["Restock"] = "Purchased ",
		},
	};


	-- Gestion XML - Menu de configuration

	CRYOLYSIS_COLOR_TOOLTIP = {
		["Purple"] = "Purple",
		["Blue"] = "Blue",
		["Pink"] = "Pink",
		["Orange"] = "Orange",
		["Turquoise"] = "Turquoise",
		["X"] = "X"
	};
	
	CRYOLYSIS_CONFIGURATION = {
		["Menu1"] = "Inventory Settings",
		["Menu2"] = "Message Settings",
		["Menu3"] = "Button Settings",
		["Menu4"] = "Timer Settings",
		["Menu5"] = "Graphical Settings",
		["MainRotation"] = "Cryolysis Angle Selection",
		["ProvisionMenu"] = "|CFFB700B7I|CFFFF00FFn|CFFFF50FFv|CFFFF99FFe|CFFFFC4FFn|CFFFF99FFt|CFFFF50FFo|CFFFF00FFr|CFFB700B7y :",
		["ProvisionMenu2"] = "|CFFB700B7P|CFFFF00FFr|CFFFF50FFo|CFFFF99FFv|CFFFFC4FFi|CFFFF99FFs|CFFFF50FFi|CFFFF00FFo|CFFB700B7n :",
		["ProvisionMove"] = "Put Food and drink in the selected bag.",
		["ProvisionDestroy"] = "Destroy all new food and drink if the bag is full.",
		["SpellMenu1"] = "|CFFB700B7S|CFFFF00FFp|CFFFF50FFe|CFFFF99FFl|CFFFFC4FFls :",
		["SpellMenu2"] = "|CFFB700B7P|CFFFF00FFl|CFFFF50FFa|CFFFF99FFy|CFFFFC4FFe|CFFFF99FFr :",
		["TimerMenu"] = "|CFFB700B7G|CFFFF00FFr|CFFFF50FFa|CFFFF99FFp|CFFFFC4FFh|CFFFF99FFi|CFFFF50FFc|CFFFF00FFa|CFFB700B7l T|CFFFF00FFi|CFFFF50FFm|CFFFF99FFe|CFFFFC4FFrs :",
		["TimerColor"] = "Show white instead of yellow timer texts",
		["TimerDirection"] = "Timers grow upwards",
		["TranseWarning"] = "Alert me when I enter a Trance State",
		["SpellTime"] = "Turn on the spell durations indicator",
		["AntiFearWarning"] = "Warn me when my target cannot be feared.",
		["GraphicalTimer"] = "Show graphical instead text timers",	
		["TranceButtonView"] = "Let me see hidden buttons to drag them.",
		["ButtonLock"] = "Lock the buttons around the Cryolysis Sphere.",
		["MainLock"] = "Lock Cryolysis Sphere.",
		["BagSelect"] = "Selection of Food and drink Container",
		["BuffMenu"] = "Put buff menu on the left",
		["PortalMenu"] = "Put portal menu on the left",
		["STimerLeft"] = "Show timers on the left side of the button",
		["ShowCount"] = "Show item count in Cryolysis",
		["CountType"] = "Event Shown on sphere",
		["Food"] = "Food Threshold",
		["Sound"] = "Activate sounds",
		["ShowMessage"] = "Random Speeches",
		["ShowPortalMessage"] = "Activate random speeches (Portal)",
		["ShowSteedMessage"] = "Activate random speeches (Steed)",
		["ShowPolyMessage"] = "Activate random speeches (Polymorph)",
		["ChatType"] = "Declare Cryolysis messages as system messages",
		["CryolysisSize"] = "Size of the main Cryolysis button",
		["StoneScale"] = "Size of other buttons",
		["PolymorphSize"] = "Size of the Polymorph button",
		["TranseSize"] = "Size of Transe and Anti-fear buttons",
		["Skin"] = "Drink Threshold",
		["ManaStoneOrder"] = "Use this mana gem first",
		["Show"] = {
			["Text"] = "Show Buttons:",
			["Food"] = "Food button",
			["Drink"] = "Drink button",
			["Manastone"] = "Mana Gem button",
			["LeftSpell"] = "Left Spell Button",
			["Evocation"] = "Evocation",
			["RightSpell"] = "Right Spell Button",
			["Steed"] = "Steed",
			["Buff"] = "Spell menu",
			["Portal"] = "Portal menu",
			["Tooltips"] = "Show tooltips",
			["Spelltimer"] = "Spelltimer Button"
		},
		["Text"] = {
			["Text"] = "On Button:",
			["Food"] = "Food Count",
			["Drink"] = "Drink Count",
			["Manastone"] = "Mana Gem Cooldown",
			["Evocation"] = "Evocation Cooldown",
			["Powder"] = "Arcane Powder",
			["Feather"] = "Light Feathers",
			["Rune"] = "Portal Runes",
		},
		["QuickBuff"] = "Open/Close buff menu on mouse-over",
		["Count"] = {
			["None"] = "None",
			["Provision"] = "Food and Drinks",
			["Provision2"] = "Drinks and Food",
			["Health"] = "Current Health",
			["HealthPercent"] = "Health Percent",
			["Mana"] = "Current Mana",
			["ManaPercent"] = "Mana Percent",
			["Manastone"] = "Mana Gem Cooldown",
			["Evocation"] = "Evocation Cooldown",
		},
		["Circle"] = {
			["Text"] = "Event shown on circle",
			["None"] = "None",
			["HP"] = "Hit Points",
			["Mana"] = "Mana",
            ["Manastone"] = "Mana Gem Cooldown",
			["Evocation"] = "Evocation cooldown",

		},
		["Button"] = {
			["Text"] = "Main button function",
			["Consume"] = "Eat and Drink",
			["Evocation"] = "Use Evocation",
			["Polymorph"] = "Cast Polymorph",
			["Manastone"] = "Mana Gem",
		},
		["Restock"] = {
			["Restock"] = "Automatically restock my reagents",
			["Confirm"] = "Confirm before any purchase",			
		},
		["Polymorph"] = {
			["Warn"] = "Warn me before polymorph breaks",
			["Break"] = "Tell me when polymorph breaks",
		},
		["ButtonText"] = "Show reagent count on buttons",
		["Anchor"] = {
			["Text"] = "Menu anchor point",
			["Above"] = "Above",
			["Center"] = "Center",
			["Below"] = "Below"
		},
		["SpellButton"] = {	
			["Armor"] = CRYOLYSIS_SPELL_TABLE[22].Name.."/"..CRYOLYSIS_SPELL_TABLE[24].Name, -- "Ice Armor / Mage Armor"
			["ArcaneInt"] = CRYOLYSIS_SPELL_TABLE[4].Name.."/"..CRYOLYSIS_SPELL_TABLE[2].Name, --"Arcane Int / Arcane Brilliance",
			["DampenMagic"] = CRYOLYSIS_SPELL_TABLE[13].Name.."/"..CRYOLYSIS_SPELL_TABLE[1].Name, -- "Dampen Magic / Amplify Magic",
			["IceBarrier"] = CRYOLYSIS_SPELL_TABLE[23].Name.."/"..CRYOLYSIS_SPELL_TABLE[25].Name, -- "Ice Barrier / Mana Shield",
			["FireWard"] = CRYOLYSIS_SPELL_TABLE[15].Name.."/"..CRYOLYSIS_SPELL_TABLE[20].Name, -- "Fire Ward / Frost Ward",
			["DetectMagic"] = CRYOLYSIS_SPELL_TABLE[50].Name, -- "Detect Magic"
			["RemoveCurse"] = CRYOLYSIS_SPELL_TABLE[33].Name, -- Remove Lesser curse
			["SlowFall"] = CRYOLYSIS_SPELL_TABLE[35].Name, -- Slow Fall
		},		
	};
end                                                         