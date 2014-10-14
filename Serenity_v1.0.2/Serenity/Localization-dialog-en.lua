------------------------------------------------------------------------------------------------------
-- Serenity
--
-- Based on Necrosis LdC by Lomig and Nyx (http://necrosis.larmes-cenarius.net)
-- Original Necrosis Idea : Infernal (http://www.revolvus.com/games/interface/necrosis/)
-- Serenity Maintainer : Kaeldra of Aegwynn
--
-- Contact : darklyte@gmail.com
-- Send me in-game mail!  Yersinia on Aegwynn, Horde side.
-- Guild: <Working as Intended>
-- Version Date: 08.20.2006
------------------------------------------------------------------------------------------------------


------------------------------------------------
-- ENGLISH  VERSION TEXTS --
------------------------------------------------

function Serenity_Localization_Dialog_En()

	function SerenityLocalization()
		Serenity_Localization_Speech_En();
	end

	SERENITY_COOLDOWN = {
		["Potion"] = "Potion Cooldown"
	};

	SerenityTooltipData = {
		["Main"] = {
			Label = "|c00FFFFFFSerenity|r",
			["HealingPotion"] = "Healing Potions: ",
			["ManaPotion"] = "Mana Potions: ",
			["Drink"] = "Drinks: ",
			["HolyCandle"] = "Holy Candles: ",
			["SacredCandle"] = "Sacred Candles: ",
			["LightFeather"] = "Light Feathers: ",
  		},
		["Alt"] = {
			Left = "Right-click for ",
			Right = "",
		},
		["Potion"] = {
			Label = "|c00FFFFFFPotion|r",
			Text = {"Restores ", " over ", " to "}
		},
		["SpellTimer"] = {
			Label = "|c00FFFFFFSpell Durations|r",
			Text = "Cooldowns and Active Spells on the target",
			Right = "Right Click for Hearthstone to "
		},
		
		["Fortitude"] = {
			Label = "|c00FFFFFF"..SERENITY_SPELL_TABLE[38].Name.."|r"
		},
		["DivineSpirit"] = {
			Label = "|c00FFFFFF"..SERENITY_SPELL_TABLE[8].Name.."|r"
		},
		["ShadowProtection"] = {
			Label = "|c00FFFFFF"..SERENITY_SPELL_TABLE[51].Name.."|r"
		},
		["InnerFire"] = {
			Label = "|c00FFFFFF"..SERENITY_SPELL_TABLE[20].Name.."|r"
		},
		["Levitate"] = {
			Label = "|c00FFFFFF"..SERENITY_SPELL_TABLE[23].Name.."|r"
		},
		["FearWard"] = {
			Label = "|c00FFFFFF"..SERENITY_SPELL_TABLE[11].Name.."|r"
		},
		["ElunesGrace"] = {
			Label = "|c00FFFFFF"..SERENITY_SPELL_TABLE[9].Name.."|r"
		},
		["Shadowguard"] = {
			Label = "|c00FFFFFF"..SERENITY_SPELL_TABLE[54].Name.."|r"
		},
		["TouchOfWeakness"] = {
			Label = "|c00FFFFFF"..SERENITY_SPELL_TABLE[59].Name.."|r"
		},
		["Feedback"] = {
			Label = "|c00FFFFFF"..SERENITY_SPELL_TABLE[12].Name.."|r"
		},
		["InnerFocus"] = {
			Label = "|c00FFFFFF"..SERENITY_SPELL_TABLE[19].Name.."|r"
		},
		["PowerInfusion"] = {
			Label = "|c00FFFFFF"..SERENITY_SPELL_TABLE[37].Name.."|r"
		},
		["Shadowform"] = {
			Label = "|c00FFFFFF"..SERENITY_SPELL_TABLE[53].Name.."|r"
		},
		["IceBarrier"] = {
			Label = "|c00FFFFFF"..SERENITY_SPELL_TABLE[23].Name.."|r"
		},
		["ManaShield"] = {
			Label = "|c00FFFFFF"..SERENITY_SPELL_TABLE[25].Name.."|r"
		},
		["Fade"] = {
			Label = "|c00FFFFFF"..SERENITY_SPELL_TABLE[10].Name.."|r"
		},
		["Mount"] = {
			Label = "|c00FFFFFFSteed: "
		},
		["Buff"] = {
			Label = "|c00FFFFFFBuff Menu|r\nMiddle-click to keep the menu open"
		},
		["Spell"] = {
			Label = "|c00FFFFFFSpells Menu|r\nMiddle click to keep the menu open"
		},
		["Lightwell"] = {
		    Label = "|c00FFFFFF"..SERENITY_SPELL_TABLE[24].Name.."|r"
		},
		["Resurrection"] = {
		    Label = "|c00FFFFFF"..SERENITY_SPELL_TABLE[48].Name.."|r"
		},
		["Scream"] = {
		    Label = "|c00FFFFFF"..SERENITY_SPELL_TABLE[45].Name.."|r"
		},
		["MindControl"] = {
		    Label = "|c00FFFFFF"..SERENITY_SPELL_TABLE[33].Name.."|r"
		},
		["MindSoothe"] = {
		    Label = "|c00FFFFFF"..SERENITY_SPELL_TABLE[35].Name.."|r"
		},
		["MindVision"] = {
		    Label = "|c00FFFFFF"..SERENITY_SPELL_TABLE[36].Name.."|r"
		},
		["ShackleUndead"] = {
		    Label = "|c00FFFFFF"..SERENITY_SPELL_TABLE[49].Name.."|r"
		},
		["Dispel"] = {
			Label = "|c00FFFFFFDispel Magic|r"
		},
		["LastSpell"] = {
			Left = "Right-click to recast ",      
			Right = "",
		},
		["Drink"] = {
			Label = "|c00FFFFFFDrink|r",
		},
	};


	SERENITY_SOUND = {
		["ShackleWarn"] = "Interface\\AddOns\\Serenity\\sounds\\Shackle01.mp3",
		["ShackleBreak"] = "Interface\\AddOns\\Serenity\\sounds\\Shackle02.mp3",
		["Shackle"] = "Interface\\AddOns\\Serenity\\sounds\\Shackle03.mp3",
	};


--	SERENITY_NIGHTFALL_TEXT = {
--		["NoBoltSpell"] = "You do not seem to have any Shadow Bolt Spell.",
--		["Message"] = "<white>S<lightPurple1>h<lightPurple2>a<purple>d<darkPurple1>o<darkPurple2>w T<darkPurple1>r<purple>a<lightPurple2>n<lightPurple1>c<white>e"
--	};


	SERENITY_MESSAGE = {
		["Error"] = {
			["HolyCandleNotPresent"] = "Missing Reagent: Holy Candle",
			["SacredCandle"] = "Missing Reagent: Sacred Candle",
			["LightFeatherNotPresent"] = "Missing Reagent: Light Feather",
			["NoRiding"] = "You do not have any Steed to ride!",
			["FullMana"] = "You cannot use that since you have full MP",
			["FullHealth"] = "You cannot use that since you have full HP",
			["NoHearthStone"] = "Error: You do not have a Hearthstone in your inventory",
			["NoPotion"] = "Error: You do not have that potion in your inventory",
			["NoDrink"] = "Error: You do not have drinks in your inventory",
			["PotionCooldown"] = "Error: Potion currently on cooldown!",
			["NoSpell"] = "Error: You do not know that spell",
		},
		["Interface"] = {
			["Welcome"] = "<white>/serenity or /seren to access my menu.",
			["TooltipOn"] = "Tooltips turned on" ,
			["TooltipOff"] = "Tooltips turned off",
			["MessageOn"] = "Chat messaging turned on",
			["MessageOff"] = "Chat messaging turned off",
			["MessagePosition"] = "<- System messages by Serenity will appear here ->",
			["DefaultConfig"] = "<lightYellow>Default configuration loaded.",
			["UserConfig"] = "<lightYellow>Configuration loaded."
		},
		["Personality"] = {
			["Greeting"] = "Hello, "..UnitName("player")..", nice to meet you",
			["Welcome"] = "Welcome back, "..UnitName("player"),
			["Signal"] = "You can't stop the signal.",
		},
		["Help"] = {
			"/serenity recall -- Center Serenity and all buttons in the middle of the screen",
			"/serenity sm -- Replace messages with a short raid-ready version",
			"/serenity reset -- Restore and reload default Serenity configurations",
			"/serenity toggle -- hide/show the main serenity sphere",
			"change the spell buttons by adjusting the sliders in the button menu",			
		},
		["Information"] = {
			["ShackleWarn"] = "Shackle Undead is about to break",
			["ShackleBreak"] = "Your Shackles has broken...",
			["Restocked"] = "Purchased ",
			["Restock"] = "Restock Candles?",
			["Yes"] = "Yes",
			["No"] = "No",
		},
	};


	-- Gestion XML - Menu de configuration

	SERENITY_COLOR_TOOLTIP = {
		["Purple"] = "Purple",
		["Blue"] = "Blue",
		["Pink"] = "Pink",
		["Orange"] = "Orange",
		["Turquoise"] = "Turquoise",
		["X"] = "X"
	};
	
	SERENITY_CONFIGURATION = {
		["Menu1"] = "General Settings",
		["Menu2"] = "Message Settings",
		["Menu3"] = "Button Settings",
		["Menu4"] = "Timer Settings",
		["Menu5"] = "Graphical Settings",
		["MainRotation"] = "Serenity Angle Selection",
		["InventoryMenu"] = "|CFFB700B7I|CFFFF00FFn|CFFFF50FFv|CFFFF99FFe|CFFFFC4FFn|CFFFF99FFt|CFFFF50FFo|CFFFF00FFr|CFFB700B7y :",
		["InventoryMenu2"] = "|CFFB700B7P|CFFFF00FFr|CFFFF50FFo|CFFFF99FFv|CFFFFC4FFi|CFFFF99FFs|CFFFF50FFi|CFFFF00FFo|CFFB700B7n :",
		["ProvisionMove"] = "Put Potion and drink in the selected bag.",
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
		["ButtonLock"] = "Lock the buttons around the Serenity Sphere.",
		["MainLock"] = "Lock Serenity Sphere.",
		["BagSelect"] = "Selection of Potion and drink Container",
		["BuffMenu"] = "Put buff menu on the left",
		["SpellMenu"] = "Put Spell menu on the left",
		["STimerLeft"] = "Show timers on the left side of the button",
		["ShowCount"] = "Show item count in Serenity",
		["CountType"] = "Event Shown on sphere",
		["Potion"] = "Potion Threshold",
		["Sound"] = "Activate sounds",
		["ShowMessage"] = "Random Speeches",
		["ShowResMessage"] = "Activate random speeches (Resurrection)",
		["ShowSteedMessage"] = "Activate random speeches (Steed)",
		["ShowShackleMessage"] = "Activate random speeches (Shackle Undead)",
		["ChatType"] = "Declare Serenity messages as system messages",
		["SerenitySize"] = "Size of the main Serenity button",
		["StoneScale"] = "Size of other buttons",
		["ShackleUndeadSize"] = "Size of the Shackle Undead button",
		["TranseSize"] = "Size of Transe and Anti-fear buttons",
		["Skin"] = "Drink Threshold",
		["PotionOrder"] = "Use this Potion first",
		["Show"] = {
			["Text"] = "Show Buttons:",
			["Potion"] = "Potion button",
			["Drink"] = "Drink button",
			["Dispel"] = "Dispel button",
			["LeftSpell"] = "Left Spell Button",
			["MiddleSpell"] = "Middle Spell Button",
			["RightSpell"] = "Right Spell Button",
			["Steed"] = "Steed",
			["Buff"] = "Buff menu",
			["Spell"] = "Spell menu",
			["Tooltips"] = "Show tooltips",
			["Spelltimer"] = "Spelltimer Button"
		},
		["Text"] = {
			["Text"] = "On Button:",
			["Potion"] = "Potion Count",
			["Drink"] = "Drink Count",
			["Potion"] = "Potion Cooldown",
			["Evocation"] = "Evocation Cooldown",
			["HolyCandles"] = "Holy Candles",
			["Feather"] = "Light Feathers",
			["SacredCandles"] = "Sacred Candles",
		},
		["QuickBuff"] = "Open/Close buff menu on mouse-over",
		["Count"] = {
			["None"] = "None",
			["Candles"] = "Candles",
			["Drink"] = "Drink Quantity",
			["PotionCount"] = "Mana/Healing Potion Quantity",
			["Health"] = "Current Health",
			["HealthPercent"] = "Health Percent",
			["Mana"] = "Current Mana",
			["ManaPercent"] = "Mana Percent",
			["PotionCooldown"] = "Potion Cooldown",
		},
		["Circle"] = {
			["Text"] = "Event shown on around sphere",
			["None"] = "None",
			["HP"] = "Hit Points",
			["Mana"] = "Mana",
            ["Potion"] = "Potion Cooldown",
			["FiveSec"] = "Five Second Rule",
			["Candles"] = "Candle Stock",
		},
		["Button"] = {
			["None"] = "None",
			["Text"] = "Main button function",
			["Drink"] = "Use Liquid Refreshments",
			["ManaPotion"] = "Use Mana Potion",
			["HealingPotion"] = "Use Healing Potion",
		},
		["Restock"] = {
			["Restock"] = "Automatically restock my reagents",
			["Confirm"] = "Confirm before any purchase",			
		},
		["ShackleUndead"] = {
			["Warn"] = "Warn me before Shackle Undead breaks",
			["Break"] = "Tell me when Shackle Undead breaks",
		},
		["ButtonText"] = "Show reagent count on buttons",
		["Anchor"] = {
			["Text"] = "Menu anchor point",
			["Above"] = "Above",
			["Center"] = "Center",
			["Below"] = "Below"
		},
	};
end                                                         