
local mod = thismod

mod.string.data["enUS"] = 
{
	--------------------------------------------------------------
	-- These strings are required for the mod to work correctly --
	--------------------------------------------------------------
	
	spellname = 
	{
		-- priest
		heal = "Heal",
		flashheal = "Flash Heal",
		greaterheal = "Greater Heal",
		
		-- druid
		regrowth = "Regrowth",
		healingtouch = "Healing Touch",
		
		-- paladin
		flashoflight = "Flash of Light",
		holylight = "Holy Light",
		
		-- shaman
		lesserhealingwave = "Lesser Healing Wave",
		healingwave = "Healing Wave",
		
	},
	
	caststring = "%s(Rank %d)", 	-- e.g. CastSpellByName(string.format(<caststring>, "Healing Touch", 4))
	spellrank = "Rank (%d+)", 		-- this is a parser for the second return value from GetSpellName()
	
	
	----------------------------------------------------------------------
	-- These strings are non-essential or for printout to the user only --
	----------------------------------------------------------------------
	
	loadmessage = "|cffffff00%s |cff00ff00%s.%s|r loaded. Type |cffffff00%s|r for help.",
	
	-- the Trace section is for debugging or error printouts. As such it's a low priority localisation
	trace = 
	{
		core = 
		{
			badonupdate = "The function |cffffff00%s|r in the onupdate list of the module |cffffff00%s|r is not defined."	
		},
		
		menu = 
		{
			sectionoverwrite = "The section name |cffffff00%s|r already exists; this section will not be created as a result.",
			parentnotfound = "No section has the name |cffffff00%s|r referenced by the section |cffffff00%s|r.",
		},
		
		save = 
		{
			nosavedvariables = "No saved variables exist. Creating them from defaults.",
			unusedmodule = "The module |cffffff00%s|r is defined in the saved variables data, but not in the code.",
			unusedvariable = "The variable |cffffff00%s|r in the |cffffff00%s|r module is defined in the saved variables data, but not in the code.",
			badvariablename = "The requested save variable |cffffff00%s.%s|r does not exist.",
		},
		
		data = 
		{
			badtalentname = "The talent |cffffff00%s|r does not exist.",
		}
	},
	
	-- The menu section contains all the text in the help menu. 
	menu = 
	{
		top = 
		{
			description = "Home",
			text = "Welcome to the |cffffff00%s |cff00ff00%s.%s|r Menu.\n\nThis is the Home topic. The name of the current topic is given in the box above it. The bar on the left shows topics related to this one.\n\nThe top left box is the parent of the current topic. Click it to return to the previous topic.\n\nThe boxes below it are the subtopics of the current topic. Click on them to view the particular subtopic.\n\nTo hide the help menu, navigate to the this section (keep clicking the parent box) then click the X button in the top right."
		},
		
		spellselection = 
		{
			description = "Spell Selection",
			
			hitpointvoidscale = "Hitpoint Void Scale",
			hitpointvoidscaletext = "|cffffff00Hitpoint Void Scale|r is multiplied with the player's missing hitpoints to get a target heal size. If they are missing 1000 hit points and |cffffff00Hitpoint Void Scale|r is 0.8, we will aim for a 1000 * 0.8 = 800 point heal. If it is too high, you will have to cancel your heal whenever the target gains hit points during your cast, so you will end up cancelling too many heals. If it is too low, your heals will be generally too small.",
			
			maximumoverheal = "Maximum Overheal",
			maximumoverhealtext = "Once we have a target heal size, we pick the biggest heal that will fit. We define the |cffffff00Maximum Overheal|r that our heals are allowed. This is the expected fraction of the spell that will overheal, averaged over the spell heal range and your crit chance.",
			
			minimumaverageheal = "Minimum Average Heal",
			minimumaveragehealtext = "Finally we can enforce a minimum healing amount. This will be the size of a heal spell to cast when the target is on full life. For example when healing a tank who is taking high burst damage, set this to a large amount.",	
		},
		
		spellcancelling = 
		{
			description = "Spell Cancelling",
			
			cancelzoneduration = "Cancel Zone Duration",
			cancelzonedurationtext = "|cffffff00Cancel Zone Duration|r sets the width of the Yellow Zone of the cast bar in milliseconds. In that region the mod will cancel the current spell if it is about to overheal. If the value is too small, you'll have trouble clicking the macro at the right time, particularly with a low frames per second. If the value is too high, you might be cancelling the spell unneccessarily early.",
		
			maximumoverheal = "Maximum Overheal",
			maximumoverhealtext = "|cffffff00Maximum Overheal|r is the highest acceptable percentage of a spell that will overheal. If the current spell is going to overheal more than this value, it will be cancelled if it is in the yellow zone. Be careful not to set this too low, since the mod determines the average overheal over all casts, not the overheal of the average cast. At 0%, the mod will only let a heal continue if the highest possible critical will still not overheal.",
			
		},
		
		targetselection = 
		{
			start = 
			{
				description = "Target Selection",
				text = "In this section you can configure the formulas the mod uses to determine who to heal next.\n\nWithout any modifiers, the mod will pick the person with the largest health defecit. In general, each player starts with a score, which is initially just their missing hit points. Various conditions modify the score, for instance you could set a condition 'If the player is a warrior, increase his score to 150%' (see the Class section on the left).\n\nAll modifiers are considered multipliers, so that 'increase to 150%' is implemented as 'multiply by 1.5'. So the effect of 'increase to 150%' combined with 'increase to 140%' is 1.4 * 1.5 = 210% of the original.",			},
				
			class = 
			{	
				warrior = "Warrior",
				druid = "Druid",
				shaman = "Shaman",
				warlock = "Warlock",
				paladin = "Paladin",
				mage = "Mage",
				priest = "Priest",
				rogue = "Rogue",
				hunter = "Hunter",
				
				description = "Classes",				
			},
			
			group = 
			{
				group = "Group",
				description = "Raid Groups",
			},
			
			personal = 
			{
				description = "Personal",
				text = "Increase the |cffffff00Your Party|r value to focus on healing your own party. You can use the |cffffff00Your Target|r value to focus primarily on a tank. The mod will not change your target when it heals a player, so if you keep a player targetted it will pay more attention to them.",
				group = "Your Party",
				you = "Yourself",
				target = "Your Target",
			},
			
			randomisation = 
			{
				description = "Randomisation",
				text = "If several healers in your raid are using mods to heal the raid, you will often end up targetting the same person and healing them at the same time. To prevent this, you can add a random multiplier to each target in the raid. Then the mod will end up picking one of the few most injured players in the raid, but not always the top one.",
				maxmultiplier = "Max Multiplier",
				maxmultipliertext = "|cffffff00MaxMultiplier|r sets the maximum value of the multiplier. Each player in the raid will be multiplier by a random value between 100% and |cffffff00MaxMultiplier|r. Setting the value to 100% will disable randomisation, while setting it to 200% will cause a large variation in the target selected.", 
			},
		},
		
		tutorial = 
		{
			start = 
			{
				description = "Tutorial",
				text = "This section will help you getting started and demonstrate some of the features of the mod.\n\nThe first thing to do is set up a macro to replace your heal buttons - click the Macro box on the left.",
			},
			
			macro = 
			{
				description = "Macro",
				text = "To cast a spell with the mod, first make a macro with the text following text.\n\nTo have the mod pick which spell to use and which player to target, make the text:\n    |cffffff00/script klhms.main.execute()|r\n\nYou can force the mod to cast a specific spell by adding the name of the spell to the macro, like this:\n    |cffffff00/script klhms.main.execute(\"%1$s\")|r\nThe allowed spells for your class are %2$s.\n\nAdditionally, you can force to mod to heal only your current target by adding the parameter \"target\" like so:\n    |cffffff00/script klhms.main.execute(\"%1$s\", \"target\")|r\n\nTo force the mod to heal your target without specifying the spell to use, put |cffffff00nil|r for the spell name, e.g.\n    |cffffff00/script klhms.main.execute(nil, \"target\")|r\n\nYou can add a third parameter to specify the minimum expected heal, e.g.\n    |cffffff00/script klhms.main.execute(\"%1$s\", \"target\", 900)|r",
			},
		},
		
	},
}
